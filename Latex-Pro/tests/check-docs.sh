#!/usr/bin/env bash
# Check that docs/COMMANDS.md lists every user command of the library, and
# that every command in its index really exists in a .sty file.
#
#   tests/check-docs.sh
#
# "User command" = a command or environment defined in latex-pro*.sty whose
# name has no @ or _ (internal names are left out). Theorem kinds and book
# references are found through \latexpro_newthm:nnn / \latexpro_newref:nn.
set -u
root="$(cd "$(dirname "$0")/.." && pwd)"
doc="$root/docs/COMMANDS.md"
sty=("$root"/latex-pro*.sty)

defined="$(
  {
    # \NewDocumentCommand\foo, \newcommand\foo, \DeclarePairedDelimiter\foo, ...
    grep -hoE '\\(NewDocumentCommand|RenewDocumentCommand|newcommand|DeclarePairedDelimiterX?|DeclareMathOperator\*?|cs_new_protected:Npn|cs_new_eq:NN) *\{? *\\[A-Za-z@_:]+' "${sty[@]}" \
      | grep -oE '\\[A-Za-z@_:]+$'
    # \DeclareTCBListing {pythoncode}
    grep -hoE '\\DeclareTCBListing *\{[A-Za-z@_:]+\}' "${sty[@]}" | grep -oE '\{[A-Za-z@_:]+\}' | tr -d '{}'
    # \NewDocumentEnvironment { pythoncode }
    grep -hoE '\\NewDocumentEnvironment *\{ *[A-Za-z@_:]+ *\}' "${sty[@]}" | grep -oE '\{ *[A-Za-z@_:]+' | tr -d '{ '
    # \latexpro_newthm:nnn { theorem } ..., \latexpro_newref:nn { booksection } ...
    grep -hoE '^\\latexpro_new(thm:nnn|ref:nn) *\{ *[A-Za-z@_:]+' "${sty[@]}" | grep -oE '[A-Za-z@_:]+$'
    # \newif\ifpseudoindent -> \pseudoindenttrue / \pseudoindentfalse
    grep -hoE '\\newif *\\if[A-Za-z@_:]+' "${sty[@]}" | grep -oE '\\if[A-Za-z@_:]+$' \
      | sed -E 's/^\\if(.*)/\\\1true\n\\\1false/'
  } | sed -E 's/^\\//' | grep -vE '[@_:]|^end' | sort -u
)"

fail=0
for name in $defined; do
  if ! grep -qE "(\\\\|\`)$name([^A-Za-z]|$)" "$doc"; then
    echo "FAIL  docs/COMMANDS.md does not mention \\$name"
    fail=1
  fi
done

# every \command in the index table (rows of the "Index of every command"
# section) must be defined
index="$(sed -n '/^## Index of every command/,/^---/p' "$doc")"
for name in $(echo "$index" | grep -oE '^\| `\\?[A-Za-z]+' | grep -oE '[A-Za-z]+$' | sort -u); do
  if ! grep -qxF "$name" <<<"$defined"; then
    echo "FAIL  docs/COMMANDS.md index lists \\$name, which no .sty file defines"
    fail=1
  fi
done

if ((fail)); then exit 1; fi
echo "ok    docs/COMMANDS.md covers all $(wc -w <<<"$defined") user commands"
