% Based on IAC 2024 unofficial LaTeX style & ICML 2025 LaTex style
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

%% ------------ APPEARANCE ---------------------------
% Document setup
\RequirePackage[margin=2cm,top=2cm,bottom=2cm,headheight=\baselineskip]{geometry} % page layout
\setlength{\columnsep}{0.8cm} % column spacing
\setlength{\headheight}{18pt}

% Fonts
\RequirePackage[rmdefault]{sourceserifpro}
\RequirePackage[sfdefault]{sourcesanspro}
\RequirePackage[libertine]{newtxmath}

\RequirePackage{silence}
\WarningFilter{latex}{Command \showhyphens has changed}
\RequirePackage{microtype}

\hypersetup{
    colorlinks=false,
    pdfborder={0 0 0}
}

% Source: ICML 2025 template
% Write yourself as an icmlauthor and be inspired!
\gdef\icmlfullauthorlist{}
\newcommand\addstringtofullauthorlist{\g@addto@macro\icmlfullauthorlist}
\newcommand\addtofullauthorlist[1]{%
  \ifdefined\icmlanyauthors%
    \addstringtofullauthorlist{, #1}%
  \else%
    \addstringtofullauthorlist{#1}%
    \gdef\icmlanyauthors{1}%
  \fi%
%  \ifdefined\nohyperref\else
  \ifdefined\hypersetup%
    \hypersetup{pdfauthor=\icmlfullauthorlist}%
    \fi%\fi
  }

\newenvironment{icmlauthorlist}{%
  \setlength\topsep{0pt}
  \setlength\parskip{0pt}
  \begin{center}
}{%
  \end{center}
}

\newcounter{@affiliationcounter}
\newcommand{\@pa}[1]{%
% ``#1''
\ifcsname the@affil#1\endcsname
   % do nothing
\else
  \ifcsname @icmlsymbol#1\endcsname
    % equal contribution used
    \gdef\equalContributionPresent{1}
  \else
  \stepcounter{@affiliationcounter}%
  \newcounter{@affil#1}%
  \setcounter{@affil#1}{\value{@affiliationcounter}}%
  \fi
\fi%
\ifcsname @icmlsymbol#1\endcsname
  \textsuperscript{\csname @icmlsymbol#1\endcsname\,}%
\else
  \textsuperscript{\arabic{@affil#1}\,}%
\fi
}

\newcommand{\icmlauthor}[4]{%
 \mbox{\textbf{\ifthenelse{\equal{#4}{presenting}}{\underline{#1}}{#1}}}\,%
 \ifstrempty{#3}{}{\textsuperscript{\orcidlink{#3}}}%
 \@for\theaffil:=#2\do{\@pa{\theaffil}} \addtofullauthorlist{#1}%
}

\newcommand{\icmlsetsymbol}[2]{%
  \expandafter\gdef\csname @icmlsymbol#1\endcsname{#2}
 }

\newcommand{\icmlaffiliation}[2]{%
\ifcsname the@affil#1\endcsname
 \expandafter\gdef\csname @affilname\csname the@affil#1\endcsname\endcsname{\textit{#2}}%
\else
  {\bf AUTHORERR: Error in use of \textbackslash{}icmlaffiliation command. Label ``#1'' not mentioned in some \textbackslash{}icmlauthor\{author name\}\{labels here\} command beforehand. }
  \typeout{}%
  \typeout{}%
  \typeout{*******************************************************}%
  \typeout{Affiliation label undefined. }%
  \typeout{Make sure \string\icmlaffiliation\space follows }
  \typeout{all of \string\icmlauthor\space commands}%
  \typeout{*******************************************************}%
  \typeout{}%
  \typeout{}%
\fi
}

\newcommand{\icmlcorrespondingauthor}[2]{
 \ifdefined\icmlcorrespondingauthor@text
   \g@addto@macro\icmlcorrespondingauthor@text{, #1 \authormail{#2}}
 \else
   \gdef\icmlcorrespondingauthor@text{#1 \authormail{#2}}
 \fi
}

\newcommand{\authormail}[1]{\href{mailto:#1}{\uline{#1}}}

\setlength\parindent{12pt}
\RequirePackage{caption}
\captionsetup[figure]{name=Fig.,format=hang,indention=-20pt}
\captionsetup[table]{format=hang,indention=-24pt}

\titlespacing{\section}{0pt}{*3}{*1.5}
\titlespacing{\subsection}{0pt}{*2.5}{*0.5}
\titlespacing{\subsubsection}{12pt}{*2}{*0.5}

\newcommand*{\IACpaperyear}[1]{\def\iac@paperyear{#1}}\IACpaperyear{}
\newcommand*{\IACconference}[1]{\def\iac@conference{#1}}\IACconference{}
\newcommand*{\IAClocation}[1]{\def\iac@location{#1}}\IAClocation{}
\newcommand*{\IACdate}[1]{\def\iac@date{#1}}\IACdate{}

% Set header and footer
\pagestyle{fancy}%
\fancyhf{}

% Header
\chead{\footnotesize {\iac@conference} {\iac@paperyear}, {\iac@location}, {\iac@date}}


%-----------------------------------------------------
%% ------------ SECTIONS STYLE
% Sections spacing
\titlespacing{\section}{0pt}{15pt}{1pt}%
\titlespacing{\subsection}{0pt}{15pt}{1pt}%
\titlespacing{\subsubsection}{0pt}{15pt}{1pt}%

\titleformat{\section}{\bfseries}{\arabic{section}. }{0.5em}{{#1}}%
\titleformat{\subsection}{\itshape}{\arabic{section}.\arabic{subsection}}{0.5em}{{#1}}%
\titleformat{\subsubsection}{\itshape}{\arabic{section}.\arabic{subsection}.\arabic{subsubsection}}{0.5em}{{#1}}%

% Appendix handling setup
% Customizing the appendix title format
% Define hooks to customize the formatting within the appendices
\AtBeginEnvironment{appendices}{%
    \titleformat{\section}
      {\normalfont\bfseries}
      {Appendix \thesection.}
      {1em}
      {#1}
    \titlespacing*{\section}{0pt}{5.5ex plus 1ex minus .2ex}{3.3ex plus .2ex}
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
    % Reset the title format to the default or document-wide setting
    \titleformat{\section}
      {\normalfont\Large\bfseries}
      {\thesection}
      {1em}
      {#1}
}


% Biblio handling
\bibliographystyle{unsrt}

\AtBeginDocument{
  \hypersetup{
    pdfsubject={{\iac@conference} {\iac@paperyear}, {\iac@location}, {\iac@date}}
  }
}

\newcommand{\icmlEqualContribution}{\textsuperscript{*}Equal contribution }
\newcounter{@affilnum}
\def\@maketitle{%
  \newpage
  \begin{center}%
    {\large \textbf{{\@title}} \par}%
    \vskip 1.5em%
   \end{center}%
}

\newcommand{\printAffiliations}{%
    \ifdefined\equalContributionPresent
    \icmlEqualContribution
    \fi
    \stepcounter{@affiliationcounter}%
    \forloop{@affilnum}{1}{\value{@affilnum} < \value{@affiliationcounter}}{
    \textsuperscript{\arabic{@affilnum}}\ifcsname @affilname\the@affilnum\endcsname%
    \csname @affilname\the@affilnum\endcsname%
    \else
    {\bf AUTHORERR: Missing \textbackslash{}icmlaffiliation.}
    \fi
    }.
    \ifdefined\icmlcorrespondingauthor@text
    Correspondence to: \icmlcorrespondingauthor@text.
    \else
    {\bf AUTHORERR: Missing \textbackslash{}icmlcorrespondingauthor.}
    \fi
}%