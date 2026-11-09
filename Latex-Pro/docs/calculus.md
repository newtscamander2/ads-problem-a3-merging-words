# Derivatives (`latex-pro-calculus.sty`)

Loaded by `\usepackage{latex-pro}`, or on its own with `\usepackage{latex-pro-calculus}` (which also loads `latex-pro-matrix`).

| Command | Result |
| --- | --- |
| `\partialdiff[f]{x}` | ∂f/∂x |
| `\partialdiff[f]{x,y}` | ∂²f/∂x∂y |
| `\partialdiff[f]{x,x}` | ∂²f/∂x² |
| `\partialdiff[f]{x,x,y}` | ∂³f/∂x²∂y |
| `\partialdiff{y}` | ∂f/∂y (no `[function]` uses the default function, f) |
| `\partialdiff[]{t}` | ∂/∂t (operator, no function) |
| `\setpartialdifffunction{g}` | from here on `\partialdiff{y}` gives ∂g/∂y |
| `\hessian{3}` | the 3×3 Hessian of f at v, every entry ∂²f(v)/∂xᵢ∂xⱼ written out |
| `\hessian{n}` | the general n×n Hessian with ⋯ ⋮ ⋱ |
| `\hessian[y]{2}` | Hessian in variables y₁, y₂ |
| `\hessian[x,y]{2}` | Hessian in the variables x and y (entries ∂²f(v)/∂x∂y, …) |
| `\hessian[y][g]{n}` | Hessian of g in y₁,…,yₙ |
| `\hessian[x][f][\mathbf{a}]{2}` | Hessian of f at the point **a** |
| `\hessian*{2}` | Hessian with no point, entries ∂²f/∂xᵢ∂xⱼ (the star leaves the point out) |
| `\hessian[][g]{5}` | an empty option keeps its default: variables x, function g |
| `\diff[f]{x}`, `\diff[f]{x,x}` | df/dx, d²f/dx² (same rules as `\partialdiff`, upright d) |
| `\gradient{3}` | gradient ∇f(v) as a row vector (∂f(v)/∂x₁ ⋯ ∂f(v)/∂x₃), as in the IMO26 notes |
| `\gradient*[y][g]{n}` | general gradient of g in y₁,…,yₙ, no point |
| `\gradient[x,y,z]{}` | gradient in the variables x, y, z |
| `\jacobian{2}{3}` | 2×3 derivative matrix f′(v), entries ∂fᵢ(v)/∂xⱼ |
| `\jacobian[x,y]{2}{}` | 2×2 derivative matrix in the variables x, y |
| `\jacobian*{m}{n}` | general m×n derivative matrix, no point |

Notes:

- `\partialdiff` collapses *consecutive* repeats into powers, so `{x,x,y}`
  gives ∂x²∂y, while `{x,y,x}` keeps the order you wrote. The total order
  goes on the ∂ in the numerator.
- Without `[function]`, `\partialdiff` uses the default function, which is `f`:
  `\partialdiff{y} = 2y - \cos(y)` gives ∂f/∂y = 2y − cos(y). Change it with
  `\setpartialdifffunction{g}`; the change lasts until the end of the current
  group or environment. `\setpartialdifffunction{}` makes `\partialdiff{t}` the
  operator ∂/∂t again, and `\partialdiff[]{t}` is always the operator.
  `\diff` has no default function (`\diff{t}` is d/dt), and `\hessian`,
  `\gradient` and `\jacobian` keep their own `[function]` option.
- `\hessian[variables][function][point]{dimension}` defaults to `x`, `f` and `v`.
  Leave an option empty to keep its default, e.g. `\hessian[][g]{5}` or
  `\hessian[][][\mathbf a]{2}`, and use the starred form `\hessian*` to leave the
  point out. The same goes for `\gradient` and `\jacobian`.
  The variables are either
  one symbol, `[y]` → y₁, y₂, …, or a list, `[x,y,z]` → exactly x, y, z (then the
  size comes from the list and `{}` is enough).
  The entries are built with `\partialdiff` and the matrix with `\mat`, so the
  bracket style of the matrix module applies.

Examples: [`examples/calculus.tex`](../examples/calculus.tex). Tests: [`tests/test-calculus.tex`](../tests/test-calculus.tex).
