# Code and pseudocode (`latex-pro-code.sty`)

Loaded by `\usepackage{latex-pro}`, or on its own with `\usepackage{latex-pro-code}`.

Include a file from your project as highlighted code. Both use `listings`,
so they work with plain `pdflatex` (no `-shell-escape` needed). Paths are
relative to the main `.tex` file.

```latex
\python{code/solve.py}                       % Python, with line numbers
\python[caption={Newton's method}]{newton.py}
\python[firstline=10, lastline=25]{solve.py} % only part of the file
\python*{solve.py}                           % no line numbers
\pseudo{algorithms/search.txt}               % pseudocode
\pseudo[filename=false]{search.txt}          % no file name in the header

\begin{pseudo}[caption={Binary search}]      % pseudocode typed in the .tex file
function search(A, x)
...
end function
\end{pseudo}
```

| Command | Result |
| --- | --- |
| `\python[opts]{file.py}` | the file as syntax-highlighted Python in an IDE-style box |
| `\python*{file.py}` | the same without line numbers |
| `\begin{pythoncode} ... \end{pythoncode}` | Python typed straight into the `.tex` file, same look |
| `\py{x = 1}` | a short piece of Python inline in a sentence |
| `\method{merge}` | a function name in the text, in the same font, colour and small caps as function names in the code blocks (hyphens are fine: `\method{ADD-building-to-SKYLINE}`) |
| `\variable{lo}` | a variable in the text, written as in a pseudocode block (`\variable{A_i}` is set as maths, like in `\pseudo`) |
| `\pseudo[opts]{file.txt}` | a plain-text pseudocode file, highlighted and indented |
| `\pseudo*{file.txt}` | the same without line numbers |
| `\begin{pseudo} ... \end{pseudo}` | pseudocode typed straight into the `.tex` file, handled exactly like `\pseudo` (`pseudo*` drops the line numbers; `pseudocode` is the same environment) |
| `\pseudoindentfalse` | from here on, keep the file's own indentation (`\pseudoindenttrue` turns it back on) |

`opts` is `span` / `span=false` (see *Long code* below) or any `listings` option
(`firstline`, `lastline`, `numbers=none`, …). `caption={…}` (or `title={…}`) is shown on the right of the header bar;
without it the header shows the file name. `filename=false` hides the file
name (works for `\python` and `\pseudo`): `\pseudo[filename=false]{algo.txt}`.
`\begin{pythoncode}` and `\begin{pseudo}` have no file, so they only show a caption.

### Look

**Font.** With XeLaTeX or LuaLaTeX the code is set in **JetBrains Mono**
when it can be found: installed on the computer, or the files
`JetBrainsMono-Regular.ttf`, `-Bold.ttf`, `-Italic.ttf`, `-BoldItalic.ttf`
next to your `.tex` file (on Overleaf: upload them and set the compiler to
XeLaTeX or LuaLaTeX). pdflatex cannot load it and keeps the usual typewriter
font. Function names use Latin Modern Mono Caps for the small caps, since
JetBrains Mono has none.

Every block is a rounded light-grey box with a header bar naming the
language (*Python* / *Pseudocode*) and a rule under it, in a monospace font
with GitHub-light colours, like a code block in an editor:

| What | Colour |
| --- | --- |
| keywords (`def`, `for`, `if`, `return`, `then`, …) and operators (`=`, `+`, `**`, …) | red |
| function names: a name after `def`/`class`/`function`, or used as `name(` anywhere in the file, in small caps like `\textsc{merge}` | purple |
| built-ins such as `print`, `range`, `len` | purple |
| `True`, `False`, `None`, `self` (pseudocode: `true`, `false`, `null`) | blue |
| strings | dark blue |
| comments | grey italic |

**Long code.** A box that fits on a page is kept in one piece: if it does
not fit at the bottom of the current page it moves to the next one. A box
taller than a whole page breaks across as many pages as it needs (the header
stays on the first part, and the edges where it is split are cut in a wave,
with no border; the side borders stop where the wave meets them). The wave at
the bottom of one part and the wave at the top of the next fit together like
puzzle pieces: where one bulges out, the other dips in. `length=x`
makes the waves x times as long, e.g. `\python[length=3]{long.py}`
(default `1`). The wave is the default edge style; others are `zigzag`,
`scallop`, `torn` (these also interlock), `fade`, `dashed`, `scissors`,
`continued` (a *continued on next page* label) and `straight`. Choose the
default at the top with `\usepackage[edge=zigzag]{latex-pro}` or
`\latexprocodesetup{edge=zigzag}`, and for one box with
`\python[edge=torn]{long.py}`. See
[split edge styles](COMMANDS.md#split-edge-styles) for a picture of each. `span` lets any box break, even a short one at the
bottom of a page: `\python[span]{f.py}`, `\pseudo[span]{algo.txt}`,
`\begin{pythoncode}[span]`; `span=false` never breaks, even a box taller
than a page. Nothing needs `-shell-escape`. Change the look after loading the package, e.g.

```latex
\definecolor{latexpro@keyword}{HTML}{D73A49}   % other colours: latexpro@function,
                                               % @builtin, @constant, @string,
                                               % @comment, @codebg, @codeframe
\renewcommand\latexprocodefont{\fontfamily{lmtt}\selectfont}   % another code font
\tcbset{latexpro-code/.append style={arc=0pt}}  % square corners
\renewcommand\latexprofunctionfont{}           % function names without small caps
```

What `\pseudo` does with the file:

- **Keywords highlighted**, case-insensitive: `function procedure algorithm
  return if then else elseif end for foreach each to downto by step do in
  while repeat until loop break continue and or not true false null print
  input output let call begin …`.
- **Comments.** `// …` (to the end of the line, also after code, as in
  `return x // done`) and `/* … */` are grey italic comments. Keywords and
  operators inside a comment are not coloured; maths such as `a <= b` or
  `\alpha` still becomes symbols.
- **Maths.** TeX commands are typeset as maths, so `x \geq y`, `s \gets 0`,
  `\alpha_i^2`, `\epsilon` come out as symbols. `<=`, `>=`, `!=`, `<-`,
  `->`, `<`, `>` and `*` become ≤ ≥ ≠ ← → < > ·, and single-letter
  subscripts like `a_i` or `a_{n+1}` are set as maths. A line that already
  contains `$…$` is left exactly as written (your own maths).
- **Names with hyphens.** A `-` between two letters joins one name:
  `function ADD-building-to-SKYLINE(A, b)` gives one function name in small
  caps (also wherever it is called), and `skyline-with-one` is one variable.
  A `-` before a digit or between spaces (`n-1`, `a - b`) stays a red minus,
  so put spaces around `-` when you subtract two variables.
- **Automatic indentation.** You can write every line flush left. After a
  line starting with `function`/`procedure`/`repeat`/`else`, or ending in
  `then`/`do`/`:`/`{`, or a `for`/`foreach`/`while`/`if` header, the next
  lines are indented. Lines starting with `end` (`end if`, `endfor`, …),
  `else`, `else if`, `until` or `}` step back out. A one-liner such as
  `if s = 3 then break` does not open a block.

Example `search.txt`:

```text
function hello_world(x, y)
if (x \geq y) then
print(y)
return x
else if (x < y) then
print(y)
return y
end
for i = 1 to n do
s <- s + a_i
end for
```

Notes:

- `\pseudo` writes the re-indented copy to `<jobname>-pseudo.tmp` next to
  your PDF; it is safe to delete.
- The package loads `listings`, and `xcolor` and `tcolorbox` at
  `\begin{document}` if you have not loaded them yourself, so
  `\usepackage[dvipsnames]{xcolor}` or `\usepackage[most]{tcolorbox}` still
  works anywhere in your preamble.
- Common non-ASCII letters (æ ø å ä ö ü é ß, – — “ ” …) in the code and
  comments are handled under pdflatex. Other unusual characters in a file
  need an extra `literate` entry.
- Change the look of every listing with e.g.
  `\lstdefinestyle{latexpro-python}{...}` or `latexpro-pseudo` after
  loading the package.

Examples: [`examples/code.tex`](../examples/code.tex). Tests: [`tests/test-code.tex`](../tests/test-code.tex).
