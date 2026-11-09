# Theorems and references (`latex-pro-theorems.sty`)

Loaded by `\usepackage{latex-pro}`, or on its own with `\usepackage{latex-pro-theorems}` (accepts `[bysection]`).

The package defines numbered environments for **theorem, proposition, lemma,
corollary, definition, exercise, example** and **remark** (one shared counter,
so you get Theorem 1, Lemma 2, Proposition 3, …). The command with the same
name writes the reference, with the name in small caps and the number in bold.
The argument is printed as is, just like the book references below, so
`\exercise{b}` gives "Exercise **b**". For a label of your own document,
pass its number with `\Ref*` (with hyperref, which also makes it a link) or `\ref`:

```latex
\begin{proposition}\label{prop:main}
  ...
\end{proposition}

By \proposition{\Ref*{prop:main}} and \exercise{\Ref*{ex:limits}} ...  % "Proposition 1", "Exercise 4"
See \theorem{3.2} and \exercise{b} in the course notes.              % written as is
```

| Command | Result |
| --- | --- |
| `\proposition{3}` | <span style="font-variant:small-caps">Proposition</span> **3** |
| `\exercise{b}` | <span style="font-variant:small-caps">Exercise</span> **b** |
| `\proposition{\Ref*{prop:main}}` | <span style="font-variant:small-caps">Proposition</span> **1** (number of your label, a link with hyperref) |
| `\theorem{…}` `\lemma{…}` `\corollary{…}` `\definition{…}` `\exercise{…}` `\example{…}` `\remark{…}` | the same for each kind |

Notes:

- `\proposition{prop:main}` without `\Ref*` prints the text "prop:main".
- An unknown label inside `\Ref*` shows **Proposition ??** with the usual
  LaTeX warning; compile twice as for any `\ref`.
- With `hyperref` loaded, a reference written as `\Ref*{label}` or
  `\ref*{label}` is a link to that label, for the book references too.
- Change the look with `\latexprorefstyle` (the name) and `\latexprorefnumstyle`
  (the number), e.g. `\renewcommand\latexprorefnumstyle[1]{#1}` for a plain number.
- `\usepackage[bysection]{latex-pro}` numbers them per section: 2.1, 2.2, …
- Change the printed words with e.g. `\renewcommand\exercisename{Opgave}`.
- Since the package defines these environments, remove any
  `\newtheorem{proposition}{…}` (etc.) lines from your own preamble.

## References to the book

Sections, chapters and equations of the book are written in the same style.
The argument is always printed as is, so anything works: `2.3`, `A.2`,
`3.1a`, `b`. To point at a label of your own document, pass its number with
`\Ref*` (or `\ref`):

```latex
By \booksection{2.3} and \bookeq{3.12} ...   % "Section 2.3", "Equation (3.12)"
See \bookchapter{4} and \booksection{b}.      % "Chapter 4", "Section b"
As in \bookeq{\Ref*{eq:main}}.               % "Equation (2)", from a label
```

| Command | Result |
| --- | --- |
| `\booksection{2.3}` | <span style="font-variant:small-caps">Section</span> **2.3** |
| `\bookchapter{4}` | <span style="font-variant:small-caps">Chapter</span> **4** |
| `\bookeq{3.12}`, `\bookeq{(3.12)}` | <span style="font-variant:small-caps">Equation</span> **(3.12)** |
| `\bookeq{\Ref*{eq:main}}` | the same with the number of your own label |

Notes:

- Change the words with `\renewcommand\booksectionname{Afsnit}`,
  `\bookchaptername` and `\bookeqname`.
- The theorem references (`\theorem{…}` etc.) follow the same rule.

Examples: [`examples/theorems.tex`](../examples/theorems.tex). Tests: [`tests/test-theorems.tex`](../tests/test-theorems.tex).
