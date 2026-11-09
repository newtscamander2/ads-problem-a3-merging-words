# Links (`latex-pro-links.sty`)

Loaded by `\usepackage{latex-pro}`, or on its own with `\usepackage{latex-pro-links}`.

| Command | Result |
| --- | --- |
| `\qr{https://...}` | QR code of the link, 2 cm high |
| `\qr[3cm]{https://...}` | the same, 3 cm high |
| `\qr*{https://...}` | QR code with the link printed beneath it |
| `\qr*[3cm]{https://...}` | both |
| `\qrsetsize{2.5cm}` | change the default size from here on |

Paste the link as it is. `%`, `#`, `_`, `&`, `~`, `$` and `^` need no
escaping:

```latex
\qr{https://example.com/a_b?x=1&y=%20z#top}
```

Notes:

- Load `hyperref` (anywhere in the preamble) to make the QR code and the
  printed link clickable (`\usepackage[hidelinks]{hyperref}` hides the
  coloured boxes around links). Without it they are plain.
- Inside the argument of another command (`\fbox{...}`, `\footnote{...}`,
  `\section{...}`) TeX has already read the text before `\qr` sees it, so
  `%` would start a comment there. Write `\%` and `\#` in that case;
  `\_`, `\&` and `\~` also work. Table cells and environments such as
  `center` and `figure` are fine without escaping.
- A line break inside the link is ignored, so long links can be wrapped in
  the source.
- `\qr` sits on the baseline like a letter. Use `\begin{center}...\end{center}`
  to centre it.
- Uses the `qrcode` package: pure LaTeX, works with pdflatex, no shell-escape.

Examples: [`examples/links.tex`](../examples/links.tex). Tests:
[`tests/test-links.tex`](../tests/test-links.tex),
[`tests/test-links-nohyperref.tex`](../tests/test-links-nohyperref.tex) and
[`tests/test-links-decode.tex`](../tests/test-links-decode.tex) (the QR codes
are read back from the PDF and compared with
[`tests/qr/links-decode.txt`](../tests/qr/links-decode.txt)).
