%% Copyright (C) 2003 by Jim Kenneally
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% 
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is R. Padraic Springuel.
%% Please report all bugs and problems (particularly formatting that
%% the UMaine Graduate School wants changed) to:
%%  rpspringuel@gmail.com
%%

%%%%%%%%%%%%%%%%%%%%%
% ------IDENTIFICATION------
%%%%%%%%%%%%%%%%%%%%%
\ProvidesClass{maine-thesis}[2019/07/01 v1.14 Maine thesis class]

\NeedsTeXFormat{LaTeX2e}[1999/12/01]

%%%%%%%%%%%%%%%%%%%%%
% ------INITIAL CODE------
%%%%%%%%%%%%%%%%%%%%%
\newif\ifdraft\draftfalse
\newif\iftwoside\twosidefalse
\newif\ifmt@official\mt@officialtrue
\newif\ifunbound\unboundfalse
\newif\ifmt@legacycaptions\mt@legacycaptionsfalse
\newif\ifmt@loftspace\mt@loftspacefalse
\newcommand\docsize{}
\newcommand\side{oneside}
\newcounter{secnumdefault}
\setcounter{secnumdefault}{3}
\newcounter{head} %Heading styles get numbered so that \ifcase can be used when determining which heading style is currently set instead of a nested set of \if and \else.
\setcounter{head}{1000} %The default value is set very large so that adding new styles shouldn't necessitate changing it.
\def\@margg{1.5in}
\def\mt@pagestyle{bottom}

%%%%%%%%%%%%%%%%%%%%%
% ------DECLARATION OF OPTIONS------
%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{10pt}{\renewcommand\docsize{10pt}}
\DeclareOption{11pt}{\renewcommand\docsize{11pt}}
\DeclareOption{12pt}{\renewcommand\docsize{12pt}}
\DeclareOption{draft}{\drafttrue
	\ExecuteOptions{10pt}
	\PassOptionsToClass{draft}{report}
	\newcommand{\drafttext}{\sffamily\small{DRAFT}
	\mt@officialfalse}
}
\DeclareOption{twoside}{\mt@officialfalse\unboundfalse\twosidetrue\renewcommand\side{twoside}\def\@margg{1.5in}}
\DeclareOption{oneside}{\mt@officialfalse\unboundfalse\renewcommand\side{oneside}\def\@margg{1.5in}}
\DeclareOption{unbound}{\mt@officialtrue\unboundtrue\def\@margg{1in}}
\DeclareOption{apa}{\setcounter{secnumdefault}{0}\setcounter{head}{0}}
\DeclareOption{chicago}{\setcounter{secnumdefault}{0}\setcounter{head}{1}}
\DeclareOption{headings}{\setcounter{secnumdefault}{0}\setcounter{head}{2}}
\DeclareOption{idecimal}{\setcounter{secnumdefault}{3}\setcounter{head}{3}}
\DeclareOption{jdecimal}{\setcounter{secnumdefault}{3}\setcounter{head}{1000}}
\DeclareOption{legacycaptions}{\mt@legacycaptionstrue}
\DeclareOption{pagenumberbottom}{\def\mt@pagestyle{bottom}}
\DeclareOption{pagenumbertop}{\def\mt@pagestyle{top}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{loftspacing}{\mt@loftspacetrue\mt@officialfalse}

%%%%%%%%%%%%%%%%%%%%%
% ------EXECUTION OF OPTIONS------
%%%%%%%%%%%%%%%%%%%%%
\ExecuteOptions{12pt,unbound}
\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%
% ------PACKAGE LOADING------
%%%%%%%%%%%%%%%%%%%%%
\LoadClass[\docsize,\side]{report}[2007/10/19 v1.4h Standard LaTeX document class]
\RequirePackage[T1]{fontenc}[2005/09/27 v1.99g Standard LaTeX package]
\RequirePackage{color}[2005/11/14 v1.0j Standard LaTeX Color (DPC)]
\RequirePackage{tocvsec2}[2010/02/27 v1.2b variable ToC section entries]
\RequirePackage[norule]{footmisc}[2009/09/15 v5.5a a miscellany of footnote facilities]
\RequirePackage{soul}[2003/11/17 v2.4 letterspacing/underlining  (mf)]
\RequirePackage{afterpackage}[2006/01/17 v1.1 Apply Commands After Package (NCC)]
\RequirePackage{etoolbox}[2015/08/02 v2.2a e-TeX tools for LaTeX (JAW)]
\RequirePackage[none]{hyphenat}[2009/09/02 v2.3c hyphenation utilities]
\RequirePackage{iftex}[2013/04/04 v0.2 Provides if(tex) conditional for PDFTeX, XeTeX, and LuaTeX]
\RequirePackage{geometry}[2010/09/12 v5.6 Page Geometry]
\RequirePackage{xstring}[2013/10/13 v1.7c  String manipulations (C Tellechea)]
\AfterPackage{hyperref}{% There are a few changes that are required for the hyperref package, so we make those changes if it is loaded.
	\hypersetup{ pdfdisplaydoctitle=true}
	\AtBeginDocument{
		\hypersetup{	
			pdftitle=\@title,
			pdfauthor=\@author,
			pdfcreator=\relax,
			pdfproducer=\relax % These could be changed, but for the thesis, I left them blank.
			}
	}
	% Graduate School requirements mandate a slight modification to hyperref's
	% redefinition of the caption command.
	\long\def\@caption#1[#2]#3{%
	  \ifmt@legacycaptions%
	    \def\mt@captiontext{#3}%
	  \else%
	    \IfStrEq{#2}{#3}{\def\mt@captiontext{#3}}{\def\mt@captiontext{#2\ \ignorespaces#3}}%
	  \fi%
	  \expandafter\ifx\csname if@capstart\expandafter\endcsname
	                  \csname iftrue\endcsname
	    \global\let\@currentHref\hc@currentHref
	  \else
	    \hyper@makecurrent{\@captype}%
	  \fi
	  \@ifundefined{NR@gettitle}{%
	    \def\@currentlabelname{#2}%
	  }{%
	    \NR@gettitle{#2}%
	  }%
	  \par\addcontentsline{\csname ext@#1\endcsname}{#1}{%
	    \protect\numberline{\csname fnum@#1\endcsname}{\ignorespaces #2}%
	  }%
	  \begingroup
	    \@parboxrestore
	    \if@minipage
	      \@setminipage
	    \fi
	    \normalsize
	    \expandafter\ifx\csname if@capstart\expandafter\endcsname
	                    \csname iftrue\endcsname
	      \global\@capstartfalse
	      \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces\mt@captiontext}%
	    \else
	      \@makecaption{\csname fnum@#1\endcsname}{%
	        \ignorespaces
	        \ifHy@nesting
	          \expandafter\hyper@@anchor\expandafter{\@currentHref}{\mt@captiontext}%
	        \else
	          \Hy@raisedlink{%
	            \expandafter\hyper@@anchor\expandafter{%
	              \@currentHref
	            }{\relax}%
	          }%
	          \mt@captiontext%
	        \fi
	      }%
	    \fi
	    \par
	  \endgroup
	}
}
\PassOptionsToPackage{caption=false}{subfig}

\ifPDFTeX
	\pdfsuppressptexinfo=-1 %to remove some useless tags generated by pdftex
\fi
	
%%%%%%%%%%%%%%%%%%%%%
% ------MAIN CODE------
%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
% Variable Declarations
%%%%%%%%%%%%%%%%%%%%%

\def\@title{}
\def\@author{}
\def\@authorpronoun{}
\def\@degreesheld{}
\def\@degree{}
\def\@program{}
\def\@submitdate{}
\def\@principaladvisor{}
\def\@secondadvisor{}
\def\@principalshort{}
\def\@firstreader{}
\def\@secondreader{}
\def\@thirdreader{}
\def\@fourthreader{}
\def\@fifthreader{}
\def\@bibfiles{}
\def\@type{Dissertation}
\def\@LastLevel{0}

\newif\ifmultipleappendices\multipleappendicesfalse
\newif\ifcopyrightpage\copyrightpagefalse
\newif\ifbigtitlepage\bigtitlepagefalse
\newif\ifverybigtitlepage\verybigtitlepagefalse
\newif\ifapp\appfalse

\newcount\numcomm \numcomm=4
\newcount\numadv \numadv=1

\renewcommand*\contentsname{Table of Contents}
\renewcommand*\bibname{References}
\renewcommand*\indexname{INDEX}
\renewcommand*\chaptername{Chapter}
\renewcommand*\appendixname{Appendix}
\newcommand*\listname{List of}
\newcommand*\chapternamep{\chaptername s}
\newcommand*\prefacename{Preface}
\newcommand*\acknowledgename{Acknowledgements}
\newcommand*\dedicationname{Dedication}
\newcommand*\bioname{Biography of the Author}

%%%%%%%%%%%%%%%%%%%%%
% Variable Modification Commands
%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\author}[1]{%
	\ifx\empty#1\empty\else\gdef\@author{#1}\fi}
\newcommand{\authorpronoun}[1]{%
	\ifx\empty#1\empty\else\gdef\@authorpronoun{#1}\fi}
\renewcommand{\title}[1]{%
	\ifx\empty#1\empty\else\gdef\@title{#1}\fi}
\newcommand{\degreesheld}[1]{%
	\ifx\empty#1\empty\else\gdef\@degreesheld{#1}\fi}
\newcommand{\degree}[1]{%
	\ifx\empty#1\empty\else\gdef\@degree{#1}\fi}
\newcommand{\program}[1]{%
	\ifx\empty#1\empty\else\gdef\@program{#1}\fi}
\newcommand{\submitdate}[1]{%
	\ifx\empty#1\empty\else\gdef\@submitdate{#1}\fi}
\newcommand{\principaladvisor}[2][\empty]{%
	\ifx\empty#1\empty\else\gdef\@principalshort{\sloppy#1}\fi%
	\ifx\empty#2\empty\else\gdef\@principaladvisor{\sloppy#2}\fi%
	}
\newcommand{\secondadvisor}[1]{%
	\ifx\empty#1\empty\else\gdef\@secondadvisor{\sloppy#1}\fi
	\twoadvisors}
\newcommand{\principalshort}[1]{%
	\ifx\empty#1\empty\else\gdef\@principalshort{#1}\fi}
\newcommand{\firstreader}[1]{%
	\ifx\empty#1\empty\else\gdef\@firstreader{\sloppy#1}\fi
	\members{1}}
\newcommand{\secondreader}[1]{%
	\ifx\empty#1\empty\else\gdef\@secondreader{\sloppy#1}\fi
	\members{2}}
\newcommand{\thirdreader}[1]{%
	\ifx\empty#1\empty\else\gdef\@thirdreader{\sloppy#1}\fi
	\members{3}}
\newcommand{\fourthreader}[1]{%
	\ifx\empty#1\empty\else\gdef\@fourthreader{\sloppy#1}\fi
	\members{4}}
\newcommand{\fifthreader}[1]{%
	\ifx\empty#1\empty\else\gdef\@fifthreader{\sloppy#1}\fi
	\members{5}}
\newcommand{\bibfiles}[1]{%
	\ifx\empty#1\empty\else\gdef\@bibfiles{#1}\fi}
\newcommand{\members}[1]{\numcomm=#1}
\newcommand{\twoadvisors}{\numadv=2}
\newcommand{\oneadvisor}{\numadv=1}
\newcommand{\thesis}{
	\gdef\@type{Thesis}}
\newcommand{\project}{
	\gdef\@type{Project}}
\newcommand{\compresstitlepage}[1][1]{
	\ifcase#1
		\relax
	\or
		\bigtitlepagetrue
	\or
		\bigtitlepagetrue
		\verybigtitlepagetrue
	\fi
}

%%%%%%%%%%%%%%%%%%%%%
% Special Commands
%%%%%%%%%%%%%%%%%%%%%
\newcommand{\comment}[1]{
	\ifdraft
	\marginpar{
		\color{red}\flushleft\scriptsize\setlength{\baselineskip}{7pt}
		{\MakeUppercase{Note}: #1}}
	\fi
}

\newcommand{\ignore}[1]{}

\newcommand{\toclabel}[1]{%
	\addtocontents{toc}{\protect\pagebreak[3]}
	\addtocontents{toc}{\addvspace{1em \@plus\p@}
	\parindent \z@ \rightskip \@pnumwidth
	#1}%
}

\newcommand{\pocket}[1]{
	\refstepcounter{chapter}
	\addtocontents{toc}{\protect\pagebreak[2]\vskip 10pt plus 1pt minus 1pt}
	\ifapp
		\ifmultipleappendices
			\typeout{<---- Appendix \thechapter ---->}
		\addtocontents{toc}{\protect\@dottedtocline{0}{0em}{1.4em}{\MakeUppercase{\appendixname}\space\thechapter\space -- \texorpdfstring{\MakeUppercase{#1}}{#1}}{Pocket}}
		\else
			\typeout{<---- APPENDIX ---->}%
		\addtocontents{toc}{\protect\@dottedtocline{0}{0em}{1.4em}{\MakeUppercase{\appendixname}\space -- \texorpdfstring{\MakeUppercase{#1}}{#1}}{Pocket}}
		\fi
	\else
		\typeout{*** \@chapapp\space\thechapter\space ****}
		\addtocontents{toc}{\protect\@dottedtocline{0}{0em}{1.4em}{\protect\numberline{\thechapter.}\space\texorpdfstring{\MakeUppercase{#1}}{#1}}{Pocket}}
	\fi
	\ifmt@loftspace
		\addtocontents{lof}{\protect\addvspace{\loftspacing\p@}}
		\addtocontents{lot}{\protect\addvspace{\loftspacing\p@}}
	\fi
}

\newcommand{\highlight}[1]{%
	\ifdraft%
		\hl{#1}%
	\else%
		#1%
	\fi%
}

%This is a dummy command defined to improve hyperref compatibility.
\newcommand{\texorpdfstring}[2]{%
	#1
}

%%%%%%%%%%%%%%%%%%%%%
% General Formating Declarations
%%%%%%%%%%%%%%%%%%%%%
\geometry{
	letterpaper,
	margin=1in,
	left=\@margg,
	headsep=0.4in,
	headheight=14pt,
	footskip=30pt,
	marginparwidth=40pt,
	marginparsep=10pt}
	
\setcounter{secnumdepth}{\value{secnumdefault}}
\setcounter{tocdepth}{\value{secnumdepth}}
\raggedbottom
\raggedright
\parindent=1.5em\relax
\markboth{}{}
\clubpenalty=10000
\widowpenalty=10000

\def\verbatim@font{\rmfamily}

\def\setspace@size{%
	\ifx \@currsize \normalsize
		\@normalsize
	\else
		\@currsize
	\fi
}

\def\doublespacing{%
	\ifcase \@ptsize \relax
		\def\baselinestretch{1.667}
	\or
		\def\baselinestretch{1.618}
	\or
		\def\baselinestretch{1.655}
	\fi
	\setspace@size
}

\def\onehalfspacing{%
	\ifcase \@ptsize \relax
		\def\baselinestretch{1.25}
	\or
		\def\baselinestretch{1.213}
	\or
		\def\baselinestretch{1.241}
	\fi
	\setspace@size
}

\def\singlespacing{%
	\def\baselinestretch{1}
	\setspace@size
	\vskip \baselineskip
}

\newcommand*\loftspacing{10}

%%%%%%%%%%%%%%%%%%%%%
% Header Formatting Declarations
%%%%%%%%%%%%%%%%%%%%%

\newcommand*\chaptersize{\normalsize}	

\newlength{\sectionpost}
\newlength{\subsectionpost}
\newlength{\subsubsectionpost}
\newlength{\paragraphpost}
\newlength{\subparagraphpost}
\newdimen\headindent
\headindent=1.5em
\ifcase\value{head}
	%---APA Style Headings---
	\newcommand*{\sectionstyle}{\bfseries\centering}
	\setlength{\sectionpost}{1.5ex \@plus .2ex}
	\newcommand*{\subsectionstyle}{\bfseries}
	\setlength{\subsectionpost}{.3ex \@plus .2ex}
	\newcommand*{\subsubsectionstyle}{\bfseries}
	\setlength{\subsubsectionpost}{-1em}
	\newcommand*{\paragraphstyle}{\hspace{2\headindent}\bfseries\underline}
	\setlength{\paragraphpost}{-1em}
	\newcommand*{\subparagraphstyle}{\hspace{3\headindent}\underline}
	\setlength{\subparagraphpost}{-1em}
\or
	%---Chicago Style Headings---
	\newcommand*{\sectionstyle}{\bfseries\centering}
	\setlength{\sectionpost}{1.5ex \@plus .2ex}
	\newcommand*{\subsectionstyle}{\centering}
	\setlength{\subsectionpost}{.3ex \@plus .2ex}
	\newcommand*{\subsubsectionstyle}{\bfseries}
	\setlength{\subsubsectionpost}{.2ex \@plus .1ex}
	\newcommand*{\paragraphstyle}{}
	\setlength{\paragraphpost}{.2ex \@plus .1ex}
	\newcommand*{\subparagraphstyle}{\hspace{\headindent}\bfseries}
	\setlength{\subparagraphpost}{-1em}
\or
	%---Sample Headings from Guidelines
	\newcommand*{\sectionstyle}{\bfseries\underline\centering}
	\setlength{\sectionpost}{1.5ex \@plus .2ex}
	\newcommand*{\subsectionstyle}{\bfseries}
	\setlength{\subsectionpost}{.3ex \@plus .2ex}
	\newcommand*{\subsubsectionstyle}{\bfseries\underline}
	\setlength{\subsubsectionpost}{-1em}
	\newcommand*{\paragraphstyle}{\hspace{\headindent}\underline}
	\setlength{\paragraphpost}{-1em}
	\newcommand*{\subparagraphstyle}{\hspace{\headindent}\bfseries}
	\setlength{\subparagraphpost}{-1em}
\or
	%---Indented Decimal System
	\newcommand*{\sectionstyle}{\bfseries}
	\setlength{\sectionpost}{1.5ex \@plus .2ex}
	\newcommand*{\subsectionstyle}{\hspace{\headindent}\bfseries}
	\setlength{\subsectionpost}{.3ex \@plus .2ex}
	\newcommand*{\subsubsectionstyle}{\hspace{2\headindent}\bfseries}
	\setlength{\subsubsectionpost}{.2ex \@plus .1ex}
	\newcommand*{\paragraphstyle}{\hspace{3\headindent}\bfseries}
	\setlength{\paragraphpost}{-1em}
	\newcommand*{\subparagraphstyle}{\hspace{4\headindent}\underline}
	\setlength{\subparagraphpost}{-1em}
\else
	%---Justified Decimal---
	\newcommand*{\sectionstyle}{\bfseries}
	\setlength{\sectionpost}{1.5ex \@plus .2ex}
	\newcommand*{\subsectionstyle}{\bfseries}
	\setlength{\subsectionpost}{.3ex \@plus .2ex}
	\newcommand*{\subsubsectionstyle}{\bfseries}
	\setlength{\subsubsectionpost}{.2ex \@plus .1ex}
	\newcommand*{\paragraphstyle}{\bfseries}
	\setlength{\paragraphpost}{-1em}
	\newcommand*{\subparagraphstyle}{\hspace{\parindent}\underline}
	\setlength{\subparagraphpost}{-1em}
\fi

\def\@chapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}
		\typeout{*** \@chapapp\space\thechapter\space ****}
		\addtocontents{toc}{\protect\pagebreak[3]}
		\def\@LastLevel{0}
		\addcontentsline{toc}{chapter}{\protect\numberline{\thechapter.}\space\texorpdfstring{\MakeUppercase{#1}}{#1}}
	\else
		\addtocontents{toc}{\protect\pagebreak[3]}
		\def\@LastLevel{0}
		\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{#1}}{#1}}
	\fi
	\chaptermark{#1}
	\ifmt@loftspace
		\addtocontents{lof}{\protect\addvspace{\loftspacing\p@}}
		\addtocontents{lot}{\protect\addvspace{\loftspacing\p@}}
	\fi
	\@makechapterhead{#2}
}

\def\@makechapterhead#1{%
	\cleardoublepage
	{\parindent \z@ \raggedright \centering\normalfont\chaptersize
		\ifnum \c@secnumdepth >\m@ne
			\bfseries \MakeUppercase{\chaptername}\ \thechapter
			\par\nobreak
		\fi
		\interlinepenalty\@M
		\bfseries\texorpdfstring{\MakeUppercase{#1}}{#1}\par\nobreak
		\vskip 15\p@
	}
}

\def\@makeschapterhead#1{%
	\cleardoublepage
	{\parindent \z@ \raggedright \centering\normalfont\chaptersize
		\interlinepenalty\@M
		\bfseries \texorpdfstring{\MakeUppercase{#1}}{#1}\par\nobreak
		\vskip 15\p@
	}
}

\renewcommand\part{
	\ClassError{maine-thesis}{2-Volume Thesis is no longer supported}{The Graduate School now accepts all theses electronically.\MessageBreak As a result, it no longer has any guidelines for a multi-volume print theses.\MessageBreak If you're preparing a printed thesis, try using of the twoside option to reduce\MessageBreak the page count to something which can be bound in a single volume.}
}


\renewcommand\section{
	\@startsection{section}{1}{\z@}%
	{3.5ex \@plus 1ex \@minus .2ex}%
	{\sectionpost}%
	{\sectionstyle}}

\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
	{3.25ex \@plus 1ex \@minus .2ex}%
	{\subsectionpost}%
	{\subsectionstyle}}

\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
	{3.25ex \@plus 1ex \@minus .2ex}%
	{\subsubsectionpost}%
	{\subsubsectionstyle}}

\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{\paragraphpost}%
	{\paragraphstyle}}

\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\z@}%	
	{3.25ex \@plus1ex \@minus .2ex}%	
	{\subparagraphpost}%
	{\subparagraphstyle}}

\def\app@chapter[#1]#2{%
	\ifmultipleappendices
		\ifnum \c@secnumdepth >\m@ne
			\refstepcounter{chapter}
			\typeout{<---- Appendix \thechapter ---->}
			\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\appendixname}\space\thechapter\space -- \MakeUppercase{#1}}{#1}}
		\else
			\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{#1}}{#1}}
		\fi
	\else
		\ifnum \c@secnumdepth >\m@ne
			\refstepcounter{chapter}
			\typeout{<---- APPENDIX ---->}%
			\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\appendixname}\space -- \MakeUppercase{#1}}{#1}}
		\else
			\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{#1}}{#1}}
		\fi
	   \fi
	\ifmt@loftspace
		\addtocontents{lof}{\protect\addvspace{\loftspacing\p@}}
		\addtocontents{lot}{\protect\addvspace{\loftspacing\p@}}
	\fi
	\chaptermark{#1}
	\@makeapphead{#2}
	\@afterheading
}

\def\@makeapphead#1{%
	\cleardoublepage
	{
		\parindent \z@ \raggedright \normalfont
		\ifmultipleappendices
			\ifnum\value{chapter}=1
				\centering\chaptersize\bfseries \MakeUppercase{APPENDICES}\par\nobreak
			\fi
			\centering\chaptersize\bfseries \MakeUppercase{\appendixname}\space\thechapter
		\else
			\centering\chaptersize\bfseries \MakeUppercase{\appendixname}
		\fi
		\par\nobreak
		\interlinepenalty\@M
		\centering\chaptersize\bfseries\texorpdfstring{\MakeUppercase{#1}}{#1}\par\nobreak
		\vskip 15\p@
	}
}

\setcounter{topnumber}{2}
\renewcommand\topfraction{0.8}
\setcounter{bottomnumber}{2}
\renewcommand\bottomfraction{0.8}
\setcounter{totalnumber}{4}
\renewcommand\textfraction{0.2}
\renewcommand\floatpagefraction{0.8}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{0.8}
\renewcommand\dblfloatpagefraction{0.8}

%%%%%%%%%%%%%%%%%%%%%
% Float Formatting Declarations
%%%%%%%%%%%%%%%%%%%%%
\let\latex@xfloat=\@xfloat
\def\@xfloat#1[#2]{%
	\latex@xfloat#1[#2]
	\centering
	\def\baselinestretch{1}\@normalsize
	\normalsize
}

\long\def\@makecaption#1#2{%
	\vskip\abovecaptionskip
	\sbox\@tempboxa{#1.~~#2}%
	\ifdim \wd\@tempboxa >\hsize
		{#1.~~#2}\par%
	\else
		\global \@minipagefalse
		\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
	\fi
	\vskip\belowcaptionskip
}

\long\def\@caption#1[#2]#3{%
	\ifmt@legacycaptions%
		\def\mt@captiontext{#3}%.
	\else%
		\IfStrEq{#2}{#3}{\def\mt@captiontext{#3}}{\def\mt@captiontext{#2\ \ignorespaces#3}}%
	\fi%
	\addcontentsline{\csname ext@#1\endcsname}{#1}	{\protect\numberline{\csname fnum@#1\endcsname}{\ignorespaces #2}}%
	\begingroup
	\@parboxrestore
	\normalsize
	\centering
	\@makecaption{\csname fnum@#1\endcsname}{\ignorespaces\mt@captiontext}\par
	\endgroup
}

\long\def\@footnotetext#1{%
	\insert\footins{%
		\def\baselinestretch {1}
		\reset@font\footnotesize
		\interlinepenalty\interfootnotelinepenalty
		\splittopskip\footnotesep
		\splitmaxdepth \dp\strutbox \floatingpenalty \@MM
		\hsize\columnwidth
		\@parboxrestore
		\protected@edef\@currentlabel{%
			\csname p@footnote\endcsname\@thefnmark}%
		\color@begingroup
		\@makefntext{\rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
	\color@endgroup}
}

\long\def\@mpfootnotetext#1{%
	\global\setbox\@mpfootins\vbox{%
		\unvbox \@mpfootins
		\def\baselinestretch {1}
		\reset@font\footnotesize
		\hsize\columnwidth
		\@parboxrestore
		\protected@edef\@currentlabel{%
			\csname p@mpfootnote\endcsname\@thefnmark}%
		\color@begingroup
		\@makefntext{\rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
	\color@endgroup}
}

%%%%%%%%%%%%%%%%%%%%%
% Table of Contents Formatting
%%%%%%%%%%%%%%%%%%%%%
\renewcommand\tableofcontents{%
	\chapter*{\contentsname}%
	\doublespacing
	\@starttoc{toc}
}

\renewcommand\listoftables{%
	\chapter*{\listtablename}
	\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\listtablename}}{\listtablename}}
	\doublespacing
	\setcounter{tocdepth}{\value{secnumdepth}}
	\@starttoc{lot}
}

\renewcommand\listoffigures{%
	\chapter*{\listfigurename}
	\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\listfigurename}}{\listfigurename}}
	\doublespacing
	\setcounter{tocdepth}{\value{secnumdepth}}
	\@starttoc{lof}
}

\newenvironment{thesislist}[1]{%
	\chapter*{\listname\ #1}
	\addcontentsline{toc}{chapter}{{\texorpdfstring{\MakeUppercase{\listname\ #1}}{\listname\ #1}}}
	\begingroup
}{\par\endgroup}

\renewcommand\@dotsep{1}
\renewcommand\@tocrmarg{4em}
\renewcommand\@pnumwidth{1.4em}
\patchcmd{\@dottedtocline}%
	{\rightskip\@tocrmarg}%
	{\rightskip\@tocrmarg plus 4em \hyphenpenalty\@M}%
	{%
		\patchcmd{\@dottedtocline}{\hfill}{\hskip 9.4mm plus1fill}{\typeout{5-dot minimum leader patched}}{}%
	}%
	{\ClassErrorNoLine{maine-thesis}{Unable to patch \protect\@dottedtocline\MessageBreak 5-dot leader minimum will not be respected}{Please report this error with a MWE.}}

%We use this count to prevent a page break between two toc entries when the second is one level lower than the first.
\newcount\mt@lasttocentry
\mt@lasttocentry=0
%This if is supposed to keep the first two entries at a level together.
\newif\ifmt@isfirst
\mt@isfirsttrue

\renewcommand*\l@chapter{%
	\ifnum\mt@lasttocentry=0\relax%
		\nopagebreak%
		\mt@isfirsttrue%
	\else%
		\ifmt@isfirst\nopagebreak\fi%
		\mt@isfirstfalse%
	\fi%
	\mt@lasttocentry=1%
	\vskip 12pt plus 1pt minus 1pt%
	\@dottedtocline{0}{0em}{1.4em}}
\renewcommand*\l@section{%
	\ifnum\mt@lasttocentry=1\relax%
		\nopagebreak%
		\mt@isfirsttrue%
	\else%
		\ifmt@isfirst\nopagebreak\fi%
		\mt@isfirstfalse%
	\fi%
	\mt@lasttocentry=2%
	\ifnum\c@tocdepth>0 \vskip 5pt plus 1pt minus 1pt \fi%
	\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand*\l@subsection{%
	\ifnum\mt@lasttocentry=2\relax%
		\nopagebreak%
		\mt@isfirsttrue%
	\else%
		\ifmt@isfirst\nopagebreak\fi%
		\mt@isfirstfalse%
	\fi%
	\mt@lasttocentry=3%
	\ifnum\c@tocdepth>1 \vskip 4pt minus 1pt \fi%
	\@dottedtocline{2}{3.8em}{3.2em}}
\renewcommand*\l@subsubsection{%
	\ifnum\mt@lasttocentry=3\relax%
		\nopagebreak%
		\mt@isfirsttrue%
	\else%
		\ifmt@isfirst\nopagebreak\fi%
		\mt@isfirstfalse%
	\fi%
	\mt@lasttocentry=4%
	\ifnum\c@tocdepth>2 \vskip 3pt minus 1pt \fi%
	\@dottedtocline{3}{7.0em}{4.1em}}
\renewcommand*\l@figure{%
	\vskip 8pt plus 1pt minus 1pt%
	\@dottedtocline{1}{0em}{5.8em}}
\let\l@table\l@figure
\newcommand{\bibalign}{}

%%%%%%%%%%%%%%%%%%%%%
% Special Pages/Environments
%%%%%%%%%%%%%%%%%%%%%
\newcommand{\references}{%
	\cleardoublepage
	\singlespacing
	\phantomsection
	\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\bibname}}{\bibname}}
	\bibliography{\@bibfiles}
}

\renewenvironment{thebibliography}[1]
	{%begin
		\chapter*{\bibname}
		\bibalign\frenchspacing
		\list{\@biblabel{\@arabic\c@enumiv}}%
			{\settowidth\labelwidth{\@biblabel{#1}}%
				\leftmargin\labelwidth
				\advance\leftmargin\labelsep
				\@openbib@code
				\usecounter{enumiv}
				\let\p@enumiv\@empty
				\renewcommand\theenumiv{\@arabic\c@enumiv}}%
		\sloppy
		\sfcode`\.=\@m
	}
	{%end
		\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
		\endlist%
	}

\renewcommand\titlepage{%
	\thispagestyle{empty}
	\ifverybigtitlepage
		\onehalfspacing
	\else
		\doublespacing
	\fi
	\begin{center}
	{\bfseries\MakeUppercase{\@title}}\\
	By \\
	\@author \\
	\@degreesheld
	\vfill
	A \MakeUppercase{\@type}\\[4pt]
	Submitted in Partial Fulfillment of the\\
	Requirements for the Degree of\\
	\expandafter{\@degree}\\
	(in \expandafter{\@program})\\
	\vskip 0.5in
	The Graduate School\\
	The University of Maine\\
	\expandafter{\@submitdate}
	\vfill
	\end{center}
	\ifbigtitlepage
		\singlespacing
	\fi
	Advisory Committee:
	\begin{list}{}{%
		\setlength{\itemsep}{0pt}%
		\setlength{\topsep}{0in}%
		\setlength{\partopsep}{0pt}%
		\setlength{\itemindent}{-\parindent}%
		\setlength{\leftmargin}{1cm}%
		}
	\item{\@principaladvisor, %
		\ifnum\numadv=2%
			Co-%
		\fi%
		Advisor}
	\ifnum\numadv=2
		\item{\@secondadvisor, Co-Advisor}
	\fi
	\ifnum\numcomm>0
		\item{\@firstreader}
	\fi
	\ifnum\numcomm>1
		\item{\@secondreader}
	\fi
	\ifnum\numcomm>2
		\item{\@thirdreader}
	\fi
	\ifnum\numcomm>3
		\item{\@fourthreader}
	\fi
	\ifnum\numcomm>4
		\item{\@fifthreader}
	\fi
	\end{list}
	\clearpage
}

\newcommand{\copyrightpage}[2][\@author]{%
	\copyrightpagetrue
	\onehalfspacing
	\thispagestyle{plain}
	\hbox{ }
	\vfill
	\begin{center}
	\copyright\space#2\space#1\\
	All Rights Reserved
	\end{center}
	\vfill
	\clearpage
}

\newcommand{\libraryrights}{%
	\ClassError{maine-thesis}{The Graduate School no longer requires\MessageBreak a Library Rights Statement page}{Please remove \protect\libraryrights\space from your thesis.}%
}

\newcommand{\dissacceptance}{%
	\ClassError{maine-thesis}{The Graduate School no longer requires\MessageBreak a Dissertation Acceptance page}{Please remove \protect\dissacceptance\space from your thesis.}%
}

\newcounter{mt@page}
\renewenvironment{abstract}{%
	\setcounter{mt@page}{\value{page}}
	\doublespacing
	\begin{center}
		{\bfseries\MakeUppercase{\@title}}\\
		By\space\@author\\[4pt]
		\@type\ %
		\ifnum\numadv=2%
			Co-%
		\fi%
		Advisor%
		\ifnum\numadv=2%
			s%
		\fi%
		: \@principalshort
		\vskip 0.33in
		\singlespacing
		An Abstract of the \@type\ Presented\\
		in Partial Fulfillment of the Requirements for the\\
		Degree of \@degree\\
		(in \@program)\\
		\@submitdate
		\vskip 36pt plus 2pt minus 12pt
	\end{center}
	\doublespacing
	\begingroup\par
	\pagestyle{empty}
}
{\cleardoublepage
	\par\endgroup
	\setcounter{page}{\value{mt@page}}
}

\newenvironment{layabstract}[1]{%
	\setcounter{mt@page}{\value{page}}
	\doublespacing
	\begin{center}
		{\bfseries\MakeUppercase{\@title}}\\
		By\space\@author\\[4pt]
		\@type\ %
		\ifnum\numadv=2%
			Co-%
		\fi%
		Advisor%
		\ifnum\numadv=2%
			s%
		\fi%
		: \@principalshort
		\vskip 0.33in
		\singlespacing
		A Lay Abstract of the \@type\ Presented\\
		in Partial Fulfillment of the Requirements for the\\
		Degree of \@degree\\
		(in \@program)\\
		\@submitdate
		\vskip 26pt plus 2pt minus 12pt
	\end{center}
	Keywords: \MakeLowercase{#1}
	\vskip 26pt plus 2pt minus 12pt
	\doublespacing
	\begingroup\par
	\pagestyle{empty}
}
{\cleardoublepage
	\par\endgroup
	\setcounter{page}{\value{mt@page}}
}

\newenvironment{dedication}{%
	\chapter*{\dedicationname}
	\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\dedicationname}}{\dedicationname}}
	\vskip 0.5in
	\doublespacing
	\begingroup
	\begin{center}
}{\end{center}\par\endgroup}

\newenvironment{acknowledgements}{%
	\chapter*{\acknowledgename}
	\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\acknowledgename}}{\acknowledgename}}
	\doublespacing
	\begingroup
}{\par\endgroup}

\newenvironment{preface}{%
	\chapter*{\prefacename}
	\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\prefacename}}{\prefacename}}
	\doublespacing
	\begingroup\setcounter{secnumdepth}{0}
}{\setcounter{secnumdepth}{\value{secnumdefault}}\par\endgroup}

\newenvironment{biography}{%
	\chapter*{\bioname}
	\addtocontents{toc}{\protect\nopagebreak}
	\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{\bioname}}{\bioname}}
	\begingroup
	\doublespacing
	\thispagestyle{plain}
}{\ifx\@authorpronoun\empty\@author\else\@authorpronoun\fi\ is a candidate for the \@degree\ degree in \@program\ from the University of Maine in \@submitdate.\par\endgroup}

%%%%%%%%%%%%%%%%%%%%%
% Front/Main/Back Separators
%%%%%%%%%%%%%%%%%%%%%
\newcommand{\preliminary}{%
	\pagenumbering{roman}
	\settocdepth{chapter}
}

\newcommand{\mainmatter}{%
	\cleardoublepage
	\doublespacing
	\pagenumbering{arabic}
	\ifcase\value{secnumdepth}
		\or
		\settocdepth{section}
	\or
		\settocdepth{subsection}
	\or
		\settocdepth{subsubsection}
	\or
		\settocdepth{paragraph}
	\or
		\settocdepth{subparagraph}
	\fi
}

\renewcommand{\appendix}{%
	\setcounter{chapter}{0}
	\setcounter{section}{0}
	\renewcommand*\@chapter{\app@chapter}
	\renewcommand*\thechapter{\@Alph\c@chapter}
	\addtocontents{toc}{\protect\renewcommand*\protect\l@chapter{\protect\@dottedtocline{0}{0pt}{7.5em}}}
	\ifmultipleappendices%
		\toclabel{Appendices}
	\fi%
	\settocdepth{chapter}
	\doublespacing
	\apptrue
}

%%%%%%%%%%%%%%%%%%%%%
% Page Style Definitions
%%%%%%%%%%%%%%%%%%%%%

\newcommand{\ps@bottom}{%
	\renewcommand{\@oddhead}{%
		\ifdraft\drafttext\hfil\today\hfil\drafttext\else\fi}%
	\renewcommand{\@evenhead}{\@oddhead}
	\renewcommand{\@oddfoot}{%
		\ifdraft\drafttext\hfil\thepage
		\hfil\drafttext\else\hfil\thepage\hfil\fi}
	\renewcommand{\@evenfoot}{\@oddfoot}
}

\renewcommand{\ps@empty}{%
	\renewcommand{\@oddhead}{%
		\ifdraft\drafttext\hfil\today\hfil\drafttext\else\fi}%
	\renewcommand{\@evenhead}{\@oddhead}
	\renewcommand{\@oddfoot}{%
		\ifdraft\drafttext\hfil\drafttext\else\fi}
	\renewcommand{\@evenfoot}{\@oddfoot}
}

\newcommand{\ps@top}{%
	\renewcommand{\@oddhead}{%
		\ifdraft\drafttext\fi\hfil
		\ifdraft\today\else\thepage\fi
		\ifdraft\hfil\drafttext\fi}
	\renewcommand{\@evenhead}{%
		\ifdraft\drafttext\hfil\fi
		\ifdraft\today\else\thepage\fi
		\hfil\ifdraft\drafttext\fi}	
	\renewcommand{\@oddfoot}{%
		\ifdraft\drafttext\hfil\thepage\hfil\drafttext\fi}
	\renewcommand{\@evenfoot}{\@oddfoot}
}


\pagestyle{\mt@pagestyle}
\renewcommand{\ps@plain}{\csname ps@\mt@pagestyle\endcsname}


\endinput
%%
%% End of file `maine-thesis.cls'.
