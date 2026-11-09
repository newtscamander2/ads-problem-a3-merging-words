# Sets (`latex-pro-sets.sty`)

Loaded by `\usepackage{latex-pro}`, or on its own with `\usepackage{latex-pro-sets}`.

| Command | Result |
| --- | --- |
| `\N \Z \Q \R` | ℕ ℤ ℚ ℝ |
| `\set{1,2,3}` | {1, 2, 3} |
| `\setof{x \in S}{p(x)}` | {x ∈ S \| p(x)} |
| `\ball{v}{\epsilon}` | open ball B(v, ε) |
| `\dist{u}{v}` | d(u, v) |
| `\interior{S}`, `\bd{S}` | interior S°, boundary ∂S |
| `\Rx`, `\Rx[t]` | polynomials ℝ[x], ℝ[t] |

Notes:

- Loads `amssymb` and `mathtools`. If another package already defines `\R`,
  `\set` etc., LaTeX stops with an "already defined" error naming the clash.
- `\set*{…}` and `\setof*{…}{…}` grow with the contents.

Examples: [`examples/sets.tex`](../examples/sets.tex). Tests: [`tests/test-sets.tex`](../tests/test-sets.tex).
