# General notation (`latex-pro-notation.sty`)

Loaded by `\usepackage{latex-pro}`, or on its own with `\usepackage{latex-pro-notation}`.

| Command | Result |
| --- | --- |
| `\norm{x}`, `\abs{x}` | ‖x‖, \|x\| (`\norm*{…}` grows with the contents) |
| `\inner{u}{v}` | ⟨u, v⟩ |
| `A\tp` | transpose Aᵀ |
| `\map{f}{\R^n}{\R}` | f : ℝⁿ → ℝ |
| `\defeq` | := |
| `\argmin_{x \in C} f(x)`, `\argmax` | arg min with the subscript underneath |
| `\minimize{f(x)}{x \in \R^n \\ Ax \le b}` | min with the constraints stacked under it |
| `\maximize{c\tp x}{x \ge 0}` | same with max |

Notes:

- Loads `mathtools`. If another package already defines `\norm`, `\abs` etc.,
  LaTeX stops with an "already defined" error naming the clash.

Examples: [`examples/notation.tex`](../examples/notation.tex). Tests: [`tests/test-notation.tex`](../tests/test-notation.tex).
