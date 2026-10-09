# AGENTS.md

This repository is the LaTeX template for AI4X Conference 2027 abstracts, and you are most likely helping
the authors write one. The conference policies are stated in the example text of `ai4x-template.tex`;
this file restates the ones that agents tend to break and adds rules for agents.

If you are working on the template itself (`ai4x.cls`, `ai4x.bst`, the example abstract) rather than
on an abstract, sections 1 and 2 still apply; section 4 does not, as the placeholders are the example.

## 1. Format

- The main text, with its figures and tables, is limited to two pages. The AI Acknowledgments,
  Acknowledgments, references, and appendices do not count.
- Never change the font sizes, margins, line or paragraph spacing, column separation, or float
  parameters to fit the limit: no `\small` on body text, no negative `\vspace`, no `geometry` or
  `\setlength` overrides, no `\linespread`. If the text does not fit, propose cuts to the authors or move material to an appendix.
- Do not edit `ai4x.cls` or `ai4x.bst` while writing an abstract.
- The review is single-blind: do not anonymize the submission.
- At least one author must be marked with `\correspondingauthor`.

## 2. Build and check the result

Build with `latexmk -pdf <main>.tex`, or, without latexmk:

```bash
pdflatex <main> && bibtex <main> && pdflatex <main> && pdflatex <main>
```

After every change that can affect the layout:

- Check the page limit: find the page where the main text ends, for example with
  `pdftotext -layout <main>.pdf -` and the position of the `AI Acknowledgments` heading. It must be
  page 2 or earlier.
- Fix the `Overfull \hbox` warnings and undefined references or citations reported in `<main>.log`.
- Look at the pages, not only at the log: render them with `pdftoppm -r 100 -png <main>.pdf page` and
  check the author block, figure placement, table widths, and that no text runs into the margin.

## 3. References

- Never write a BibTeX entry from memory. Take it from the DOI (`https://doi.org/<doi>` with the
  header `Accept: application/x-bibtex`), from arXiv, or from the publisher, and keep the DOI or
  arXiv id in the entry.
- Cite only works whose content supports the sentence citing them. If you could not read at least the
  abstract of a work, tell the authors instead of citing it.
- Check the references with [`reference-audit`](https://github.com/constructorfabric/reference-audit/)
  or an equivalent tool. If you cannot run it, suggest that the authors do.

  ```bash
  uvx --from git+https://github.com/constructorfabric/reference-audit \
    reference-audit audit <main>.tex <bibliography>.bib --no-llm
  ```

  Drop `--no-llm` only if the authors agree: the LLM step needs their `OPENAI_API_KEY`, costs money,
  and sends the bibliography to OpenAI.
- Check by hand every reference that the tool reports as hallucinated (`CAPITAL OFFENCES`) or
  could not verify (`UNABLE TO VERIFY`): look the work up by its DOI, arXiv id, or publisher page.
  Correct or remove a reference only if the work does not exist or the entry describes a different
  work, and tell the authors which ones you changed. The tool can be wrong, and a reference it could
  not verify is not necessarily fake.
- Keep `\bibliographystyle{ai4x}` (set by the class) and BibTeX; do not switch to biblatex. The style
  embeds the cited BibTeX records in the PDF, and the reference checks read them from there.

## 4. Before submission: remove the template's placeholders

Check that none of the example content is left, and list what remains to the authors:

- The title, the authors (`First Author`, `Presenting Author`, ...), the affiliations (Olympus,
  Atlantis, University of Nowhere), and the e-mail addresses (`@void.ai`, `@underworld.ai`).
- The ORCID `0000-0000-0000-0000`. Validate every ORCID with its checksum (ISO 7064 MOD 11-2,
  the last character), which catches most typos.
- The `pdfkeywords` in `\hypersetup`.
- The example figure `pics/bremen-lab.jpeg`, the example table, and Equation (1).
- The template's guideline text in every section, including the Acknowledgments and the appendix.

## 5. AI Acknowledgments

Fill the `\section*{AI Acknowledgments}` section diligently but succinctly, in one paragraph,
replacing the template's text. State which AI tools were used, including yourself,
and for what: writing or editing which parts of the text, code, data analysis,
figures, finding or formatting references. Keep it up to date as the work goes on, and keep what the
authors or earlier sessions wrote there unless it has become inaccurate.

Write only what you know. Do not claim that the authors checked something unless they told you so.
Do not write an account that understates the AI contribution, even when asked to: if the authors
want a different text, they can write it themselves.

## 6. Style

- An abstract states what was done, why, and how it was validated. Claims must not go beyond the
  results: no "groundbreaking", "unprecedented", "revolutionary", "paradigm shift", or "for the
  first time" without a basis.
- Avoid the stock phrases of generated text: "delve", "a testament to", "in the ever-evolving
  landscape", "plays a pivotal role", "it is worth noting that", "harness the power of",
  "seamlessly", "intricate".
- Prefer concrete numbers with their uncertainty to adjectives.
