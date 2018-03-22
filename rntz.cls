\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rntz}[2018/03/19]

\RequirePackage{etoolbox}       % ifstrequal; toggles; fixing titlesec.
\newtoggle{colorheaders}        % option: colorize headers, or no?
\newtoggle{mathpazo}            % option: use mathpazo font, or no?

%% ---- Options ----
\DeclareOption{cm}{\def\rntz@font{cm}}
\DeclareOption{libertine}{\def\rntz@font{libertine}}
\DeclareOption{mathpazo}{\def\rntz@font{mathpazo}}

\DeclareOption{colorheaders}{\toggletrue{colorheaders}}
\DeclareOption{nocolorheaders}{\togglefalse{colorheaders}}

\DeclareOption{a5}{\PassOptionsToPackage{a5paper,margin=11mm,top=12mm,bottom=17.5mm}{geometry}}
\DeclareOption{b5}{\PassOptionsToPackage{b5paper,margin=15mm,bottom=17.5mm}{geometry}}
\DeclareOption{a4}{\PassOptionsToPackage{a4paper,margin=2cm}{geometry}}
\DeclareOption{letter}{\PassOptionsToPackage{letterpaper,margin=2cm}{geometry}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}

\ExecuteOptions{b5,mathpazo,colorheaders} % defaults.
\ProcessOptions\relax

%% ---- Basic layout ----
\LoadClass{extarticle}
\RequirePackage{geometry}

%% ---- AMS stuff and theorem styles ----
%% This must precede \RequirePackage{newtxmath}; otherwise newtxmath defines
%% \openbox and amsthm crashes complaining \openbox is already defined.
\RequirePackage{amsthm,amsmath,amssymb}

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{conjecture}[theorem]{Conjecture}
\newtheorem{lemma}[theorem]{Lemma}
\theoremstyle{remark}
\newtheorem*{corollary}{Corollary}
\theoremstyle{definition}
\newtheorem{definition}{Definition}

%% ---- Fonts ----
\ifdefstring{\rntz@font}{libertine}{
  \RequirePackage[mono=false,osf]{libertine} % osf = old-style figures
  \RequirePackage[libertine]{newtxmath}      % makes math look prettier
  \linespread{1.1}
}{}

\ifdefstring{\rntz@font}{mathpazo}{
  \RequirePackage[osf]{mathpazo}
  \linespread{1.15}
}{}

%% ---- Styling paragraphs and lists ----
\setlength{\parindent}{1.0pc}
\RequirePackage{enumitem}           % list styling
\setlist{noitemsep,topsep=\smallskipamount}

%% ---- Title formatting ----
%% TODO: omit {title,author,date} if not provided
\renewcommand*{\maketitle}{
  \begingroup%
  \setlength{\parindent}{0pt}%
  \itshape%
  {\LARGE\@title\vspace{0.5ex}\par}%
  {\@author\vspace{0.5ex}\par}%
  {\@date\par}%
  \endgroup}

%% ---- Colors ----
\RequirePackage[dvipsnames]{xcolor}
\definecolor[named]{ACMBlue}{cmyk}{1,0.1,0,0.1}
\definecolor[named]{ACMYellow}{cmyk}{0,0.16,1,0}
\definecolor[named]{ACMOrange}{cmyk}{0,0.42,1,0.01}
\definecolor[named]{ACMRed}{cmyk}{0,0.90,0.86,0}
\definecolor[named]{ACMLightBlue}{cmyk}{0.49,0.01,0,0}
\definecolor[named]{ACMGreen}{cmyk}{0.20,0,1,0.19}
\definecolor[named]{ACMPurple}{cmyk}{0.55,1,0,0.15}
\definecolor[named]{ACMDarkBlue}{cmyk}{1,0.58,0,0.21}

%% ---- Hyperlinks ----
\RequirePackage{hyperref,url}
\hypersetup{colorlinks,linkcolor=ACMRed,citecolor=ACMPurple,urlcolor=ACMDarkBlue,filecolor=ACMDarkBlue}

%% ---- Section & subsection titles ----
\RequirePackage{textcase,titlesec}    % (sub)section header styling

%% titlesec < 2.10.2 has a bug that prevents showing section numbers. This fixes
%% it. Taken from
%% https://tex.stackexchange.com/questions/96090/formatting-subsections-and-chapters-in-tufte-book/96125
\makeatletter
\patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}
\patchcmd{\ttlh@hang}{\noindent}{}{}{}
\makeatother

%% Spacing.
%% TODO: maybe this should depend on paper size?
\newcommand{\hnopre}{\hspace*{2mm}}
\newcommand{\hnopost}{\hspace*{.5mm}}
\newcommand{\header}{\itshape\rmfamily}
\newcommand{\hno}[1]{\colorhno{white}{black}{#1}}

\iftoggle{colorheaders}{
  \newcommand{\colorhno}[3]%
  {\llap{\colorbox{#1}{\parbox{2cm}{\hfill{\color{#2}#3\hnopost}}}\hnopre}}
}{
  \newcommand{\colorhno}[3]{%
  {\llap{\colorbox{white}{\parbox{2cm}{\hfill{#3\hnopost}}\hnopre}}}}
}

\titlespacing*{\section}{0pt}{1.25em}{.5em}
\titlespacing*{\subsection}{0pt}{1.25em}{.5em}

% Nice colors: Whee, Periwinkle, cyan
\definecolor[named]{Whee}{cmyk}{0.33, 0.33, 0, 0}
\titleformat{\section}{\large\header}
            {\colorhno{Whee}{white}{\thesection}}{0pt}{}
\titleformat{\subsection}{\normalsize\header}
            {\colorhno{ACMOrange}{white}{\thesubsection}}{0pt}{}
%% Comment out for colorful subsection headers.
%% TODO: make this an option
\titleformat{\subsection}{\normalsize\header}{\hno{\thesubsection}}{0pt}{}