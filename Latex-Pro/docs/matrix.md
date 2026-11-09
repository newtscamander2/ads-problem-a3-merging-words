# Matrices and vectors (`latex-pro-matrix.sty`)

Loaded by `\usepackage{latex-pro}`, or on its own with `\usepackage{latex-pro-matrix}` (accepts `[square]`).

| Command | Result |
| --- | --- |
| `\bmat{1 & 2 \\ 3 & 4}` | matrix in square brackets (`bmatrix`) |
| `\mat{1 & 2 \\ 3 & 4}` | matrix in the current bracket style (round by default) |
| `\usematb`, `\usematp` | switch `\mat` and every matrix command to square / round brackets |
| `\pmat{a & b \\ c & d}` | matrix in round brackets (`pmatrix`) |
| `\idmat{3}` | the 3×3 identity matrix, written out |
| `\idmat{n}` | the general n×n identity matrix with ⋯ ⋮ ⋱ |
| `\colvec{n}`, `\colvec[v]{3}` | column vector (x₁,…,xₙ) / (v₁,v₂,v₃) |
| `\rowvec[w]{4}` | row vector [w₁ w₂ w₃ w₄] |
| `\rowvec[x,y]`, `\rowvec[1, 2]` | row vector with exactly those entries, printed with commas: (x, y), (1, 2) |
| `\colvec[x, y, z]` | column vector with exactly those entries |
| `\genmat{m}{n}`, `\genmat[b]{2}{3}` | general matrix with entries aᵢⱼ |
| `\symmat{n}`, `\symmat[s]{3}` | general symmetric matrix, aᵢⱼ above the diagonal and mirrored below |
| `\symmat{e & 0 \\ 0 & d}` | symmetric matrix from all its rows |
| `\symmat{1 & 2 & 3 \\ 4 & 5 \\ 6}` | symmetric matrix from its upper triangle (row by row, diagonal included) |
| `\symmat[e,d]{2}` | diagonal matrix with e, d on the diagonal and 0 elsewhere |
| `\symmat[d_1,d_2,d_n]{n}` | general diagonal matrix (entries for rows 1, 2 and n) |
| `\diagmat{e, d}` | same as `\symmat[e,d]{2}`, size taken from the list |

Notes:

- **Bracket style.** Every matrix command (`\idmat`, `\colvec`, `\rowvec`,
  `\genmat`, `\symmat`, `\diagmat`, and `\hessian`, `\gradient`, `\jacobian`
  from the calculus module) uses round brackets by default. Put `\usematb` at
  the top of the document (after `\begin{document}` or in the preamble) for
  square brackets, or load the package as `\usepackage[square]{latex-pro}`.
  `\usematp` switches back, and inside a group `{\usematb ...}` the change
  stays local.
- These commands share one matrix builder, so a number writes every entry and
  anything else (`n`, `m`, …) gives the dotted general form.
- Empty options fall back to the default in `\colvec`, `\rowvec`, `\genmat`
  and `\symmat`, e.g. `\colvec[]{2}` is `\colvec[x]{2}`.

Examples: [`examples/matrix.tex`](../examples/matrix.tex). Tests: [`tests/test-matrix.tex`](../tests/test-matrix.tex).
