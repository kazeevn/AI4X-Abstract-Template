% Based on the unofficial IAC LaTeX template by J. O. Woods, D. Grande and S. Farì
% (github.com/grande-dev/International-Astronautical-Congress-LaTeX-template);
% the author block reuses the ICML 2025 LaTeX style
% See COPYRIGHT for the authorship history
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ai4x}[AI4X conference style]

\LoadClass[twocolumn,a4paper,10pt]{article}
\setlength\parskip{0pt} % no spacing at double return carriage

%% ------------ PACKAGES -----------------------------
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage[explicit,compact]{titlesec}
\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}
\RequirePackage{forloop}
\RequirePackage{alphalph}
\RequirePackage{float}
\RequirePackage{booktabs}
\RequirePackage[titletoc,toc,title]{appendix}
\RequirePackage{anyfontsize}
\RequirePackage[colorlinks,pdfusetitle,pdftex]{hyperref}
\RequirePackage{xurl}
\RequirePackage{orcidlink}

\renewcommand{\headrulewidth}{0pt}

%% ------------ CONFERENCE ---------------------------
% Used in the page header and in the PDF metadata
\newcommand*{\ai@venue}{AI4X Conference 2027, Bremen, Germany, June 14\textendash 17}

%% ------------ APPEARANCE ---------------------------
% Document setup
\RequirePackage[margin=2cm,top=2cm,bottom=2cm,headheight=\baselineskip]{geometry} % page layout
\setlength{\columnsep}{0.8cm} % column spacing
\setlength{\headheight}{18pt}

% Fonts
\RequirePackage[rmdefault]{sourceserifpro}
\RequirePackage[sfdefault]{sourcesanspro}
% Source Serif has no math companion: newtxmath provides the symbols,
% mathastext sets the math letters and digits in Source Serif itself
\RequirePackage{newtxmath}
\RequirePackage[italic,noplusnominus,noequal]{mathastext}

\RequirePackage{silence}
\WarningFilter{latex}{Command \showhyphens has changed}
\RequirePackage{microtype}

\hypersetup{
    colorlinks=false,
    pdfborder={0 0 0}
}

%% ------------ AUTHORS ------------------------------
\gdef\ai@fullauthorlist{}
\newcommand\ai@addstringtofullauthorlist{\g@addto@macro\ai@fullauthorlist}
\newcommand\ai@addtofullauthorlist[1]{%
  \ifdefined\ai@anyauthors%
    \ai@addstringtofullauthorlist{, #1}%
  \else%
    \ai@addstringtofullauthorlist{#1}%
    \gdef\ai@anyauthors{1}%
  \fi%
  \ifdefined\hypersetup%
    \hypersetup{pdfauthor=\ai@fullauthorlist}%
    \fi%
  }

\newenvironment{authorlist}{%
  \setlength\topsep{0pt}
  \setlength\parskip{0pt}
  \begin{center}
}{%
  \end{center}
}

\newcounter{@affiliationcounter}
\newcommand{\ai@pa}[1]{%
% ``#1''
\ifcsname the@affil#1\endcsname
   % do nothing
\else
  \ifcsname ai@symbol@#1\endcsname
    % equal contribution used
    \gdef\ai@equalpresent{1}
  \else
  \stepcounter{@affiliationcounter}%
  \newcounter{@affil#1}%
  \setcounter{@affil#1}{\value{@affiliationcounter}}%
  \fi
\fi%
\ifcsname ai@symbol@#1\endcsname
  \textsuperscript{\csname ai@symbol@#1\endcsname\,}%
\else
  \textsuperscript{\arabic{@affil#1}\,}%
\fi
}

\newcommand{\paperauthor}[4]{%
 \mbox{\textbf{\ifstrequal{#4}{presenting}{\underline{#1}}{#1}}}\,%
 \ifstrempty{#3}{}{\textsuperscript{\orcidlink{#3}}}%
 \edef\ai@labels{\zap@space#2 \@empty}% allow "a, b" as well as "a,b"
 \@for\theaffil:=\ai@labels\do{\ai@pa{\theaffil}} \ai@addtofullauthorlist{#1}%
}

\newcommand{\setauthorsymbol}[2]{%
  \expandafter\gdef\csname ai@symbol@#1\endcsname{#2}
 }

\newcommand{\affiliation}[2]{%
\ifcsname the@affil#1\endcsname
 \expandafter\gdef\csname @affilname\csname the@affil#1\endcsname\endcsname{\textit{#2}}%
\else
  {\bf AUTHORERR: Error in use of \textbackslash{}affiliation command. Label ``#1'' not mentioned in some \textbackslash{}paperauthor\{author name\}\{labels here\} command beforehand. }
  \typeout{}%
  \typeout{}%
  \typeout{*******************************************************}%
  \typeout{Affiliation label undefined. }%
  \typeout{Make sure \string\affiliation\space follows }
  \typeout{all of \string\paperauthor\space commands}%
  \typeout{*******************************************************}%
  \typeout{}%
  \typeout{}%
\fi
}

\newcommand{\correspondingauthor}[2]{
 \ifdefined\ai@corresponding
   \g@addto@macro\ai@corresponding{, \ai@keep{#1 \authormail{#2}}}
 \else
   \gdef\ai@corresponding{\ai@keep{#1 \authormail{#2}}}
 \fi
}

% Keep an affiliation or a correspondence entry on one line, unless it is wider than the page
\newcommand{\ai@keep}[1]{%
  \sbox\z@{#1}%
  \ifdim\wd\z@>\hsize #1\else\usebox\z@\fi}

\newcommand{\authormail}[1]{\href{mailto:#1}{\uline{#1}}}

\setlength\parindent{12pt}
% A float-only column must be mostly full, otherwise floats go to the top of the next column
\renewcommand{\floatpagefraction}{0.8}
\renewcommand{\dblfloatpagefraction}{0.8}
\RequirePackage{caption}
\captionsetup{format=plain,indention=1em}

% Set header and footer
\pagestyle{fancy}%
\fancyhf{}
\fancyhead[C]{\footnotesize\ai@venue}
\fancyfoot[C]{\footnotesize\thepage}


%-----------------------------------------------------
%% ------------ SECTIONS STYLE
% Sections spacing; the starred form leaves the first paragraph unindented
\titlespacing*{\section}{0pt}{15pt}{1pt}%
\titlespacing*{\subsection}{0pt}{15pt}{1pt}%
\titlespacing*{\subsubsection}{0pt}{15pt}{1pt}%

\titleformat{\section}{\bfseries}{\thesection.}{0.5em}{#1}%
\titleformat{\subsection}{\itshape}{\thesubsection.}{0.5em}{#1}%
\titleformat{\subsubsection}{\itshape}{\thesubsubsection.}{0.5em}{#1}%

% Appendix handling setup
% Customizing the appendix title format
% Define hooks to customize the formatting within the appendices
\AtBeginEnvironment{appendices}{%
    \titleformat{\section}{\bfseries}{Appendix \thesection.}{0.5em}{#1}
    \setcounter{section}{0}%
    \setcounter{subsection}{0}%
    \setcounter{subsubsection}{0}%
    \setcounter{figure}{0}
    \setcounter{table}{0}
    \setcounter{equation}{0}
    \renewcommand{\thefigure}{A\arabic{figure}}
    \renewcommand{\thetable}{A\arabic{table}}
    \renewcommand{\theequation}{A\arabic{equation}}
}

\AtEndEnvironment{appendices}{%
    % Reset the title format to the document-wide setting
    \titleformat{\section}{\bfseries}{\thesection.}{0.5em}{#1}
}


% Biblio handling
\bibliographystyle{ai4x}

% Reference metadata: ai4x.bst passes each cited entry's BibTeX record, hex-encoded, to \aibibexport.
% The records are collected in \jobname-references.hex and embedded in the PDF as
% cited-references.bib.hex, so the references can be checked without parsing the typeset text
\RequirePackage{embedfile}
\newwrite\ai@bibexport
\newif\ifai@bibexportopen
\newif\ifai@bibexported
\newcommand{\aibibexport}[1]{%
  \ifai@bibexportopen\else
    \immediate\openout\ai@bibexport=\jobname-references.hex\relax
    \global\ai@bibexportopentrue
  \fi
  \immediate\write\ai@bibexport{#1}}
% Embedded at the end of the bibliography: embedfile writes its file list at the end of the document
\AfterEndEnvironment{thebibliography}{%
  \ifai@bibexportopen
    \immediate\closeout\ai@bibexport
    \global\ai@bibexportopenfalse
    \ifai@bibexported\else
      \embedfile[filespec=cited-references.bib.hex,mimetype=text/plain,
        desc={BibTeX records of the cited references, hex-encoded (ai4x.bst)}]{\jobname-references.hex}%
      \global\ai@bibexportedtrue
    \fi
  \fi}

\AtBeginDocument{
  \hypersetup{
    pdfsubject={\ai@venue}
  }
}

\newcommand{\ai@equalcontribution}{\textsuperscript{*}Equal contribution}
\newcounter{@affilnum}
\def\@maketitle{%
  \newpage
  \begin{center}%
    {\large \textbf{{\@title}} \par}%
    \vskip 1.5em%
   \end{center}%
}

\newcommand{\printAffiliations}{%
  \begingroup
  \centering\small
  \ifdefined\ai@equalpresent
    \ai@keep{\ai@equalcontribution}\quad
  \fi
  \stepcounter{@affiliationcounter}%
  \forloop{@affilnum}{1}{\value{@affilnum} < \value{@affiliationcounter}}{%
    \ifnum\value{@affilnum}>\@ne\quad\fi
    \ifcsname @affilname\the@affilnum\endcsname
      \ai@keep{\textsuperscript{\arabic{@affilnum}}\csname @affilname\the@affilnum\endcsname}%
    \else
      \textsuperscript{\arabic{@affilnum}}{\bfseries AUTHORERR: Missing \textbackslash{}affiliation.}%
    \fi
  }%
  \par
  \ifdefined\ai@corresponding
    Correspondence to: \ai@corresponding
  \else
    {\bfseries AUTHORERR: Missing \textbackslash{}correspondingauthor.}%
  \fi
  \par
  \endgroup
}
