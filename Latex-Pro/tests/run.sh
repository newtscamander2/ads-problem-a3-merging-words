#!/usr/bin/env bash
# Compile every test (tests/test-*.tex) and every example (examples/*.tex)
# against the .sty files in this repository, and fail if anything breaks.
#
#   tests/run.sh            everything
#   tests/run.sh matrix     only files whose name contains "matrix"
#
# A file fails when it does not compile, when an lptest check fails
# (LPTEST FAIL in the log), or when the final log still has an undefined
# reference or control sequence. Each file is compiled from its own folder,
# as you would compile it. PDFs and logs go to build/.
#
# A test with a tests/qr/<name>.txt file (<name> without "test-") also has
# its QR codes read back from the PDF, one code per page, and compared with
# the lines of that file. This needs pdftoppm (poppler-utils) and zbarimg
# (zbar-tools); without them the check is skipped with a note.
set -u
root="$(cd "$(dirname "$0")/.." && pwd)"
build="$root/build"
filter="${1:-}"
mkdir -p "$build"

# This repository's .sty files come first, so an installed copy of
# latex-pro elsewhere is never used by mistake.
export TEXINPUTS="$root//:"

pass=0
fail=0
failed=()
for tex in "$root"/tests/test-*.tex "$root"/examples/*.tex; do
  name="$(basename "$(dirname "$tex")")-$(basename "$tex" .tex)"
  [[ -n "$filter" && "$name" != *"$filter"* ]] && continue
  out="$build/$name"
  mkdir -p "$out"
  # a first line "% engine: xelatex" (or lualatex) picks the engine
  engine="-pdf"
  case "$(head -1 "$tex")" in
    *"engine: xelatex"*) engine="-xelatex" ;;
    *"engine: lualatex"*) engine="-lualatex" ;;
  esac
  if latexmk -cd $engine -interaction=nonstopmode -halt-on-error -silent \
       -outdir="$out" -jobname="$name" "$tex" >"$out/latexmk.out" 2>&1; then
    log="$out/$name.log"
    problems="$(grep -E 'LPTEST FAIL|LaTeX Warning: (Reference|There were undefined)|Undefined control sequence|Package latex-pro Warning' "$log")"
  else
    log="$out/$name.log"
    problems="$(grep -E -A3 '^!|LPTEST FAIL' "$log" 2>/dev/null | head -20)"
    [[ -z "$problems" ]] && problems="latexmk failed, see $out/latexmk.out"
  fi
  expected="$root/tests/qr/$(basename "$tex" .tex | sed 's/^test-//').txt"
  if [[ -z "$problems" && -f "$expected" ]]; then
    if command -v zbarimg >/dev/null && command -v pdftoppm >/dev/null; then
      rm -f "$out"/page-*.png
      pdftoppm -r 150 -png "$out/$name.pdf" "$out/page"
      for png in "$out"/page-*.png; do
        zbarimg -q --raw "$png" 2>/dev/null || echo "(no QR code on $(basename "$png"))"
      done >"$out/qr-decoded.txt"
      if ! diff -u "$expected" "$out/qr-decoded.txt" >"$out/qr-diff.txt"; then
        problems="QR codes decode to the wrong text:
$(tail -n +3 "$out/qr-diff.txt")"
      fi
    else
      echo "note  $name: zbarimg or pdftoppm missing, QR codes not read back"
    fi
  fi
  checks="$(grep -o 'LPTEST SUMMARY: .*' "$log" 2>/dev/null | tail -1)"
  if [[ -z "$problems" ]]; then
    pass=$((pass + 1))
    echo "ok    $name ${checks:+($checks)}"
  else
    fail=$((fail + 1))
    failed+=("$name")
    echo "FAIL  $name ${checks:+($checks)}"
    echo "$problems" | sed 's/^/      /'
  fi
done

# docs/COMMANDS.md must list every command (skipped when a filter is given)
if [[ -z "$filter" ]]; then
  if "$root/tests/check-docs.sh"; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    failed+=("check-docs")
  fi
fi

echo
echo "$pass file(s) passed, $fail failed"
if ((fail > 0)); then
  printf '  %s\n' "${failed[@]}"
  exit 1
fi
