# Latex-pro

A personal LaTeX library of maths shortcut commands. Load everything with

```latex
\usepackage{latex-pro}                  % or \usepackage[square,bysection]{latex-pro}
```

## Install

**Option A, install once for every project (recommended).** Clone (or
symlink) this repository into your personal texmf tree, then use
`\usepackage{latex-pro}` anywhere. TeX searches the folder recursively, so
every module is found.

| System | Folder |
| --- | --- |
| Windows (MiKTeX) | any folder you add under *MiKTeX Console → Settings → Directories*, inside `tex/latex/latex-pro/`, then *Tasks → Refresh file name database* |
| Windows / Linux (TeX Live) | `~/texmf/tex/latex/latex-pro/` (find it with `kpsewhich -var-value TEXMFHOME`) |
| macOS (MacTeX) | `~/Library/texmf/tex/latex/latex-pro/` |

`git pull` in that folder then updates every project at once.

**Option B, per project.** Copy every `latex-pro*.sty` file next to your
`.tex` file.

**Command reference:** [docs/COMMANDS.md](docs/COMMANDS.md) lists every
command, environment, option and setting on one page, with examples.

## Modules

`latex-pro.sty` only loads the modules below. Each one can also be loaded on
its own, e.g. `\usepackage{latex-pro-matrix}`.

| Module | Commands | Docs |
| --- | --- | --- |
| `latex-pro-matrix` | `\mat` `\bmat` `\pmat` `\usematb` `\usematp` `\idmat` `\colvec` `\rowvec` `\genmat` `\symmat` `\diagmat` | [docs/matrix.md](docs/matrix.md) |
| `latex-pro-calculus` | `\partialdiff` `\setpartialdifffunction` `\diff` `\hessian` `\gradient` `\jacobian` | [docs/calculus.md](docs/calculus.md) |
| `latex-pro-code` | `\python` `\py` `pythoncode` `\pseudo` `pseudo` `\method` `\variable` (Python and pseudocode listings) | [docs/code.md](docs/code.md) |
| `latex-pro-links` | `\qr` `\qr*` `\qrsetsize` (QR code of a pasted link) | [docs/links.md](docs/links.md) |
| `latex-pro-theorems` | theorem, proposition, lemma, … environments, `\proposition{label}` references, `\booksection` `\bookchapter` `\bookeq` | [docs/theorems.md](docs/theorems.md) |
| `latex-pro-sets` | `\N` `\Z` `\Q` `\R` `\set` `\setof` `\ball` `\dist` `\interior` `\bd` `\Rx` | [docs/sets.md](docs/sets.md) |
| `latex-pro-notation` | `\norm` `\abs` `\inner` `\tp` `\map` `\defeq` `\argmin` `\argmax` `\minimize` `\maximize` | [docs/notation.md](docs/notation.md) |

Options of `latex-pro`: `square` / `round` (bracket style of the matrix
commands), `bysection` (theorems numbered 2.1, 2.2, …) and `edge=<style>`
(how code blocks look where a page break splits them: `wave` by default,
or `zigzag`, `scallop`, `torn`, `fade`, `dashed`, `scissors`, `continued`,
`straight`; see [split edge styles](docs/COMMANDS.md#split-edge-styles)).

## Examples and tests

`examples/<module>.tex` shows every command of a module, and
`tests/test-<module>.tex` checks them. Run everything with

```sh
tests/run.sh            # all tests and examples
tests/run.sh matrix     # only the files with "matrix" in the name
```

It needs `latexmk` and uses the `.sty` files of this folder (not an installed
copy). PDFs land in `build/`. The same script runs on GitHub for every push
and pull request (*Actions → Tests*), and the PDFs can be downloaded there as
the `pdfs` artifact. Built PDFs are not committed.

A test is a small document that compares a command with the result it should
give, using `tests/lptest.sty`:

```latex
\lpsame{empty option keeps the default}{\hessian[][g]{5}}{\hessian[x][g][v]{5}}
\lpref{label after symmat}{eq:sym}{1}
```

## Adding commands

To keep parallel changes from colliding:

- Put a new command in the module it belongs to, and add it to
  [`docs/COMMANDS.md`](docs/COMMANDS.md) (index and topic section; `tests/check-docs.sh`
  fails if it is missing) and to that module's `docs/<module>.md`, an example to `examples/<module>.tex` and a
  check to `tests/test-<module>.tex`.
- A new topic gets its own `latex-pro-<topic>.sty`, `docs/<topic>.md`,
  `examples/<topic>.tex` and `tests/test-<topic>.tex`, plus one
  `\RequirePackage{latex-pro-<topic>}` line in `latex-pro.sty` and one row in
  the module table above.
- When a bug is fixed, add a test that would have caught it.
