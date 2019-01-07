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
\DeclareAuthorVariable*{coursename}
\DeclareAuthorVariable*{code}
\DeclareAuthorVariable*{instructions}
\DeclareAuthorVariable*{parts}
\DeclareAuthorVariable*{school}
\DeclareAuthorVariable*{timem}
\DeclareAuthorVariable*{hos}
\DeclareAuthorVariable*{mc}
\DeclareAuthorVariable*{iinvig}
\DeclareAuthorVariable*{examname}
\RequirePackage{caption}
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
\newtoggle{solution}
\regtotcounter{section}
\SetWatermarkText{}
\newtoggle{markingscheme}
% If we don't want to show marks for each question separately, toggle 'questionmarks'
\newtoggle{questionmarks}

\titleformat{\section}
\large{\textbf{Question \thesection:}}{0.5em}{\textbf{#1}}

\newcounter{example}
\newcounter{total}
\newcommand{\solution}[1]{\iftoggle{solution}{\textbf{Solution:} #1}{}}

\newcommand{\ms}[1]{\iftoggle{markingscheme}{\textbf{Marking Scheme:} #1}{}}

%\newcommand{\question}[2]{\item #1 ~\newline {\begin{FlushRight}\textbf{(#2)}\end{FlushRight}\addtocounter{example}{#2} \addtocounter{total}{#2}}}
%\newcommand{\question}[2]{\item #1 ~\newline {\raggedleft{\textbf{(#2)}}\addtocounter{example}{#2} \addtocounter{total}{#2}}}
%\newcommand{\question}[2]{\item #1 ~\newline {\hspace*{\fill}\textbf{(#2)}\addtocounter{example}{#2} \addtocounter{total}{#2}}}
%\newcommand{\question}[2]{\item #1  {\hspace*{\fill}\textbf{(#2)~\newline}\addtocounter{example}{#2} \addtocounter{total}{#2}}}
\newcommand{\question}[2]{\item #1  \addtocounter{example}{#2} \addtocounter{total}{#2} {\iftoggle{questionmarks}{\hspace*{\fill}\textbf{(#2)~\newline}}{}}}
\newcommand{\samplequestion}[1]{\item #1}

\newcommand{\showsolutions}{\toggletrue{solution} \SetWatermarkText{!!! Not to be shown to students !!!}\SetWatermarkLightness{0.5}\SetWatermarkScale{2}}
\newcommand{\showmarkingscheme}{\toggletrue{markingscheme}}
\newcommand{\showquestionmarks}{\toggletrue{questionmarks}}
\newcommand{\hidequestionmarks}{\togglefalse{questionmarks}}

\renewcommand{\part}[1]{\section{#1}}

%\newenvironment{questions}{\setcounter{example}{0}\begin{enumerate}}{~\newline \hspace*{\fill} \textbf{(Sub-total for the section: {\theexample})} \end{enumerate}}
\newenvironment{questions}{\setcounter{example}{0}\begin{enumerate}}{~\newline \hspace*{\fill} \textbf{(Sub-total for the section: {\theexample})} \end{enumerate}}
\newenvironment{samplequestions}{\togglefalse{questionmarks}\begin{enumerate}}{~\newline \end{enumerate}~\newline}

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

% stuff here is based on this site https://en.wikibooks.org/wiki/LaTeX/Title_Creation
\renewcommand*{\maketitle}{%
\thispagestyle{empty}
\centering
\vcenteredhbox{\includegraphics[height=2.5cm]{images/bjut}} \hspace{.5cm} {\Large \textbf{Beijing-Dublin International College}} \hspace{.5cm} \vcenteredhbox{\includegraphics[height=2.5cm]{images/ucd}}

\vspace{0.5cm}
\begin{center}
\rule{0.85\textwidth}{1pt}
\end{center}

{\large \textbf{SEMESTER {\ting@semester} {\ting@examname} - (\ting@year)}\par}

\begin{center}
\rule{0.85\textwidth}{1pt}
\end{center}
\vspace{0.5cm}

{\large \textbf{ School of \ting@school }\par}
\vspace{0.5cm}
{\LARGE \textbf{\ting@code} \textbf{\ting@coursename} \par}
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