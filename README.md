# AI4X 2027 abstract template

LaTeX template for abstracts submitted to the AI4X Conference 2027. The example abstract in
`ai4x-template.tex` explains the formatting rules and conference policies; the compiled PDF and a zip
of the sources are attached to each [release](https://github.com/kazeevn/AI4X-Abstract-Template/releases/latest).

## Usage

Download the sources from the latest release or clone the repository, then edit `ai4x-template.tex`
and `biblio.bib`. Build with

```bash
latexmk -pdf ai4x-template.tex
```

or, without latexmk,

```bash
pdflatex ai4x-template && bibtex ai4x-template && pdflatex ai4x-template && pdflatex ai4x-template
```

The zip can also be uploaded to Overleaf as a new project.

## License

BSD 2-Clause, see [LICENSE](LICENSE). The template is based on the unofficial
[International Astronautical Congress template](https://github.com/grande-dev/International-Astronautical-Congress-LaTeX-template),
and the author block reuses the ICML 2025 style.
