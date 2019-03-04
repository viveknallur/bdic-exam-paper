\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bdicexam}
\LoadClass[12pt,a4paper]{article}

\newcommand*{\@coursename}{}
\newcommand*{\coursename}[1]{\renewcommand*{\@coursename}{#1}}

% taken from http://tex.stackexchange.com/questions/93908/macro-for-declaring-variables-in-class-files
\newcommand{\DeclareAuthorVariable}{%
  \@ifstar{\ting@DeclareAuthorVariable{\ting@mandatory@var}}
          {\ting@DeclareAuthorVariable{\ting@optional@var}}%
}

% The main command; the internal version of \foo is \ting@foo
% The macro \ting@foo is initialized to give an error or an info
% message when used, so if the user doesn't provide a value for a
% mandatory variable, we'll catch the issue
\newcommand{\ting@DeclareAuthorVariable}[2]{%
  \@namedef{ting@#2}{#1{#2}}%
  \@namedef{#2}##1{\@namedef{ting@#2}{##1}}%
}
% The error and info messages
\newcommand{\ting@mandatory@var}[1]{%
  \ClassError{ting}
    {Missing value for mandatory variable
     \expandafter\string\csname#1\endcsname}
    {You have to provide a value with
     \expandafter\string\csname#1\endcsname{...}}%
}
\newcommand{\ting@optional@var}[1]{%
  \ClassInfo{ting}
    {Missing value for optional variable
     \expandafter\string\csname#1\endcsname}%
}
% finishes Here ----------------------------------------------------------------------------------------------

% Stuff for creating the headers and footers
\DeclareAuthorVariable*{semester}
\DeclareAuthorVariable*{year}
\DeclareAuthorVariable*{paper}
\DeclareAuthorVariable*{title}
\DeclareAuthorVariable*{code}
\DeclareAuthorVariable*{instructions}
\DeclareAuthorVariable*{parts}
\DeclareAuthorVariable*{school}
\DeclareAuthorVariable*{timem}
\DeclareAuthorVariable*{hos}
\DeclareAuthorVariable*{mc}
\DeclareAuthorVariable*{iinvig}
\RequirePackage{fancyhdr}
\RequirePackage{ragged2e}
\RequirePackage{tabularx}
\RequirePackage{lastpage}
\RequirePackage[explicit]{titlesec}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{totcount}
\RequirePackage{draftwatermark}
\RequirePackage[top=2cm, bottom=3cm, left=2cm, right=2cm]{geometry}
\RequirePackage{helvet}
\RequirePackage{setspace}

\RequirePackage{pdftexcmds}
\RequirePackage{catchfile}
\RequirePackage{ifluatex}
\RequirePackage{ifplatform}
%\RequirePackage{filecontents}
%\usepackage{shellesc}
\usepackage{pdftexcmds}
\usepackage{catchfile}
\usepackage{ifluatex}
%\usepackage{ifplatform}
\regtotcounter{section}
\SetWatermarkText{}


\newtoggle{solution}
\newtoggle{markingscheme}
\newtoggle{resitF}
\togglefalse{resitF}
\titleformat{\section}
\large{\textbf{Question \thesection:}}{0.5em}{\textbf{#1}}

\newcounter{example}
\newcounter{total}

\newcommand{\solution}[1]{\iftoggle{solution}{\textbf{Solution:} #1}{}}

\newcommand{\ms}[1]{\iftoggle{markingscheme}{\textbf{Marking Scheme:} #1}{}}


\newcommand{\question}[2]{\item #1 ~\newline \addtocounter{example}{#2} \addtocounter{total}{#2} {\hspace*{\fill}\textbf{(#2\%)}}}

\newcommand{\showsolutions}{\toggletrue{solution} \SetWatermarkText{!!! Not to be shown to students !!!}\SetWatermarkLightness{0.5}\SetWatermarkScale{2}}
\newcommand{\showmarkingscheme}{\toggletrue{markingscheme}}
\newcommand{\resit}{\toggletrue{resitF}}

\renewcommand{\part}[1]{\section{#1}}

\newenvironment{questions}{\setcounter{example}{0}\begin{enumerate}}{\vspace*{-\baselineskip}~\newline \hspace*{\fill} \textbf{(Total {\theexample}\%)}\end{enumerate}}

\pagestyle{fancy}
\lhead{BDIC}
\chead{Semester {\ting@semester}}
\rhead{Academic Year (\ting@year)}
\lfoot{}
\cfoot{Page {\thepage} of {\pageref{LastPage}}}
\rfoot{}
\newcommand*{\vcenteredhbox}[1]{\begingroup
\setbox0=\hbox{#1}\parbox{\wd0}{\box0}\endgroup}

\newcommand{\vcenteredinclude}[1]{\begingroup
\setbox0=\hbox{\includegraphics{#1}}%
\parbox{\wd0}{\box0}\endgroup}
\ifmacosx
\immediate\write18{mkdir -p images}
\fi
\input{images.tex}

% stuff here is based on this site https://en.wikibooks.org/wiki/LaTeX/Title_Creation
\renewcommand*{\maketitle}{%
\ifwindows
\immediate\write18{certutil -decode images/ucd.64 images/ucd-tmp.jpg}
\immediate\write18{certutil -decode images/bjut.64 images/bjut-tmp.jpg}
\fi
\iflinux %base64 -d data.b64 > data.txt
\immediate\write18{base64 -d images/ucd.64 > images/ucd-tmp.jpg}
\immediate\write18{base64 -d images/bjut.64 > images/bjut-tmp.jpg}

\fi %base64 -D -i data.b64 -o data.txt
\ifmacosx
\immediate\write18{base64 -D -i images/ucd.64  -o images/ucd-tmp.jpg}
\immediate\write18{base64 -D -i images/bjut.64  -o images/bjut-tmp.jpg}

\fi

\thispagestyle{empty}
\centering
\vcenteredhbox{\includegraphics[height=2.5cm]{images/bjut-tmp}} \hspace{.5cm} {\Large \textbf{Beijing-Dublin International College}} \hspace{.5cm} \vcenteredhbox{\includegraphics[height=2.5cm]{images/ucd-tmp}}

\vspace{0.5cm}
\begin{center}
\rule{0.85\textwidth}{1pt}
\end{center}

{\large \textbf{SEMESTER {\ting@semester} \iftoggle{resitF}{RESIT}{FINAL} EXAMINATION - (\ting@year)}\par}

\begin{center}
\rule{0.85\textwidth}{1pt}
\end{center}
\vspace{0.5cm}

{\large \textbf{ School of \ting@school }\par}
\vspace{0.5cm}
{\LARGE \textbf{\ting@code} \textbf{\ting@title} \par}
\vspace{0.5cm}
{\large \textbf{\ting@hos} \par}
{\large \textbf{\ting@mc}* \par}
\vspace{0.5cm}
{\Large \textbf{Time Allowed: \ting@timem\hspace{0.2cm}minutes} \par}
\vspace{0.5cm}

{\large \textbf{Instructions for Candidates:}\\
\vspace{0.4cm}
\onehalfspacing {\ting@instructions}}
\vspace{0.5cm}


\justifying \noindent \textbf{BJUT Student ID:}\rule{4cm}{0.6pt} \hspace{1cm}\textbf{UCD Student ID:}\rule{4cm}{0.6pt}\\

\justifying \noindent \onehalfspacing
I have read and clearly understand the Examination Rules of both Beijing University of Technology and University College Dublin. I am aware of the Punishment for Violating the Rules of Beijing University of Technology and/or University College Dublin. I hereby promise to abide by the relevant rules and regulations by not giving or receiving any help during the exam. If caught violating the rules, I accept the punishment thereof.

\vspace{0.4cm}

\noindent \textbf{Honesty Pledge:}\rule{11cm}{0.8pt} \textbf{(Signature)}\\          
           


\vspace{1cm}
{\large \centering \textbf{Instructions for Invigilators}  \par}
\centering \ting@iinvig
\newpage
\justifying \singlespacing
}
\endinput

