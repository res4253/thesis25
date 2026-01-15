% 長岡技術科学大学 平田研究室 
% 学位論文 クラス
%
% Author : K. ABIKO
% Time-stamp: <2019-12-05 18:11:37 akutsu>
% 
% 各種論文に対応．
%
% 既知の問題点：
% 1. Unused global option {doctor,master,bachelor}が出る

%%%%%%%
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{csl-thesis}[2011/05/29 v.1.0 by Koichi ABIKO]
\typeout{Thesis Class for Control Systems Laboratory, Nagaoka University of Technology.}

\DeclareOption{doctor}{\def\thesistitle{博\ 士\ 学\ 位\ 論\ 文}}
\DeclareOption{master}{\def\thesistitle{修\ 士\ 学\ 位\ 論\ 文}}
\DeclareOption{bachelor}{\def\thesistitle{卒\ 業\ 研\ 究\ 論\ 文}}


\DeclareOption{draft}{\PassOptionsToClass{draft}{jsbook}}


\ExecuteOptions{bachelor}

\ProcessOptions\relax

%\LoadClass[12pt,a4paper,twoside,openright]{jsbook}
\LoadClass[11pt,a4paper,twoside,openright]{jsbook}




%%%%%%
\def\@ptsize{0} \@namedef{ds@11pt}{\def\@ptsize{1}}
\@namedef{ds@12pt}{\def\@ptsize{2}} 
\def\ds@twoside{\@twosidetrue \@mparswitchtrue}
\def\ds@draft{\overfullrule 5truept} 
\@options
%\input jrep1\@ptsize.sty\relax


\parindent      1.0zw
\topmargin      -0.3truein
\oddsidemargin  0.0truein
\evensidemargin 0.0truein
\textwidth      6.3truein
\textheight     9.57truein

\def\labelenumi{\theenumi.} 
\def\theenumi{\arabic{enumi}} 
\def\labelenumii{(\theenumii)}
\def\theenumii{\alph{enumii}}
\def\p@enumii{\theenumi}
\def\labelenumiii{\theenumiii.}
\def\theenumiii{\roman{enumiii}}
\def\p@enumiii{\theenumi(\theenumii)}
\def\labelenumiv{\theenumiv.}
\def\theenumiv{\Alph{enumiv}} 
\def\p@enumiv{\p@enumiii\theenumiii}

\def\labelitemi{$\bullet$}
\def\labelitemii{\textgt{--}}
\def\labelitemiii{$\ast$}
\def\labelitemiv{$\cdot$}

\def\verse{\let\\=\@centercr 
  \list{}{\itemsep\z@ \itemindent -1.5em\listparindent \itemindent 
    \rightmargin\leftmargin\advance\leftmargin 1.5em}\item[]}
\let\endverse\endlist
\def\quotation{\list{}{\listparindent 1.5em
    \itemindent\listparindent
    \rightmargin\leftmargin\parsep 0truept plus 1truept}\item[]}
\let\endquotation=\endlist
\def\quote{\list{}{\rightmargin\leftmargin}\item[]}
\let\endquote=\endlist

\def\descriptionlabel#1{\hspace\labelsep \textbf{#1}}
\def\description{\list{}{\labelwidth\z@ \itemindent-\leftmargin
    \let\makelabel\descriptionlabel}}
\let\enddescription\endlist
\newdimen\descriptionmargin
\descriptionmargin=3em


\def\titlepage{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
  \else \newpage \fi \thispagestyle{empty}\c@page\z@}
\def\endtitlepage{\if@restonecol\twocolumn \else \newpage \fi}

\arraycolsep 5truept \tabcolsep 6truept \arrayrulewidth .4truept \doublerulesep 2truept 
\tabbingsep \labelsep 
\skip\@mpfootins = \skip\footins
\fboxsep = 3truept \fboxrule = .4truept 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 部・章・節の番号の設定

\def\thepart {\Roman{part}}
\def\thechapter {\arabic{chapter}}
\def\thesection {\thechapter.\arabic{section}}
\def\thesubsection {\thesection.\arabic{subsection}}
\def\thesubsubsection {\thesubsection.\arabic{subsubsection}}
\def\theparagraph {\thesubsubsection.\arabic{paragraph}}
\def\thesubparagraph {\theparagraph.\arabic{subparagraph}}
%\def\@chapapp{Chapter}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 部・章・節のページ設定

%% jsbook の仕様で，節タイトルがサンセリフ体になる．
%% これをボールド体にするため，以下のコマンドを入れる．2011/08/18
\renewcommand{\headfont}{\bfseries}


\def\@makechapterhead#1{ \vspace*{20truept} \thispagestyle{fancy} { \parindent 0truept \raggedright 
    \ifnum \c@secnumdepth >\m@ne \huge\textbf{\@chapapp{} \thechapter \ \@chappos}\par
    \vskip 20truept \fi \Huge \textbf{#1} \par 
    \nobreak \vskip 40truept } }  %%%章の最初のページ：\thispagestyle{fancy}に変更

\def\part{\cleardoublepage \thispagestyle{plain} \if@twocolumn \onecolumn
  \@tempswatrue \else \@tempswafalse \fi \hbox{}\vfil \secdef\@part\@spart} 

\def\@part[#1]#2{\ifnum \c@secnumdepth >-2\relax \refstepcounter{part}
  \addcontentsline{toc}{part}{\thepart \hspace{1em}#1}\else
  p\addcontentsline{toc}{part}{#1}\fi \markboth{}{}
  {\centering \ifnum \c@secnumdepth >-2\relax \huge\textbf{Part \thepart} \par
    \vskip 20truept \fi \Huge \textbf{#1} \par}\@endpart} 
\def\@endpart{\vfil\newpage \if@twoside \hbox{} \thispagestyle{empty} 
  nnn \newpage 
  \fi \if@tempswa \twocolumn \fi} 
\def\@spart#1{{\centering \Huge \textbf{#1}\par}\@endpart}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 目次の設定

\def\@pnumwidth{1.55em}
\def\@ppnumwidth{0.55em}
\def\@tocrmarg {2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{2}

%% \def\tableofcontents{%
%%   \if@twocolumn\@restonecoltrue\onecolumn
%%   \else\@restonecolfalse\fi
%%   \chapter*{目 次\@mkboth{目 次}{目 次}}
%%   \@starttoc{toc}%
%%   \if@restonecol\twocolumn\fi}

%% \def\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
%% \def\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
%% \def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
%% \def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
%% \def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

%% \def\listoffigures{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
%%   \fi\chapter*{図 目 次\@mkboth
%%     {図 目 次}{図 目 次}}\@starttoc{lof}\if@restonecol\twocolumn
%%   \fi}
%% \def\l@figure{\@dottedtocline{1}{1.5em}{2.8em}}
%% \def\listoftables{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
%%   \fi\chapter*{表 目 次\@mkboth
%%     {表 目 次}{表 目 次}}\@starttoc{lot}\if@restonecol
%%   \twocolumn\fi}
%% \let\l@table\l@figure

\def\tableofcontents{%
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
  \chapter*{目 次\@mkboth{目 次}{目 次}}
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi}

\renewcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{1.0em \@plus\p@}
    \begingroup
      \parindent\z@
      \rightskip\@tocrmarg
      \parfillskip-\rightskip
      \leavevmode\headfont
      % \if@english\setlength\@lnumwidth{5.5em}\else\setlength\@lnumwidth{4.683zw}\fi
      \setlength\@lnumwidth{1.5em}\advance\@lnumwidth 2.683zw
      \advance\leftskip\@lnumwidth \hskip-\leftskip
      #1\nobreak\hfil\nobreak\hbox to\@pnumwidth{\hss#2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\def\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\def\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

\def\listoffigures{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
  \fi\chapter*{図 目 次\@mkboth
    {図 目 次}{図 目 次}}\@starttoc{lof}\if@restonecol\twocolumn
  \fi}
\def\l@figure{\@dottedtocline{1}{1.5em}{2.8em}}
\def\listoftables{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
  \fi\chapter*{表 目 次\@mkboth
    {表 目 次}{表 目 次}}\@starttoc{lot}\if@restonecol
  \twocolumn\fi}
\let\l@table\l@figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 参考文献の設定

\usepackage[resetlabels]{multibib}
\newcommand{\PUB}{本研究に関する論文および講演}
%\newcites{pub}{本研究に関する論文および講演}
\newcites{trn}{学会論文誌}
\newcites{intcon}{国際学会発表}
\newcites{domcon}{国内学会発表}
\newdimen\bibindent
\setlength\bibindent{2zw}

%% \def\thebibliography#1{%
%%   \setcounter{chapter}{0}%
%%   \markright{\bibname}%
%%   \addcontentsline{toc}{chapter}{\bibname}
%%   \chapter*{\bibname\@mkboth{\bibname}{\bibname}}
%%   \thispagestyle{fancy}%
%%    \list{\@biblabel{\@arabic\c@enumiv}}%
%%         {%\settowidth\labelwidth{\@biblabel{#1}}%
%%          \leftmargin\labelwidth
%%          \advance\leftmargin\labelsep
%%          \@openbib@code
%%          \usecounter{enumiv}%
%%          \let\p@enumiv\@empty
%%          \renewcommand\theenumiv{\@arabic\c@enumiv}}%
%%    \sloppy
%%    \clubpenalty4000
%%    \@clubpenalty\clubpenalty
%%    \widowpenalty4000%
%%    \sfcode`\.\@m%
%% }
%% \let\endthebibliography=\endlist

\def\thebibliography#1{%
  \setcounter{chapter}{0}%
  \thispagestyle{fancy}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {%\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty\clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m%
}
\let\endthebibliography=\endlist


%% \def\thebibliography#1{%
%%   \setcounter{chapter}{0}
%%   \markright{\bibname}
%%   \chapter*{\bibname\@mkboth{\bibname}{\bibname}}
%%   \list
%%  {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
%%  \advance\leftmargin\labelsep
%%  \usecounter{enumi}}
%%  \def\newblock{\hskip .11em plus .33em minus .07em}
%%  \sloppy
%%  \sfcode`\.=1000\relax
%%  \thispagestyle{fancy}
%%  \addcontentsline{toc}{chapter}{\bibname}}
%% \let\endthebibliography=\endlist


%\def\newblock{\hskip .11em plus .33em minus .07em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 索引の設定

\newif\if@restonecol
\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
  \columnseprule \z@
  \columnsep 35truept\twocolumn[\@makeschapterhead{索 引}]
  \@mkboth{索 引}{索 引}\thispagestyle{plain}\parindent\z@
  \parskip\z@ plus .3truept\relax\let\item\@idxitem}
\def\@idxitem{\par\hangindent 40truept}
\def\subitem{\par\hangindent 40truept \hspace*{20truept}}
\def\subsubitem{\par\hangindent 40truept \hspace*{30truept}}
\def\endtheindex{\if@restonecol\onecolumn\else\clearpage\fi}
\def\indexspace{\par \vskip 10truept plus 5truept minus 3truept\relax}

\def\footnoterule{\kern-3\p@ 
  \hrule width .4\columnwidth 
  \kern 2.6\p@} 
\@addtoreset{footnote}{chapter} 
\long\def\@makefntext#1{\parindent 1em\noindent 
  \hbox to 1.8em{\hss$^{\@thefnmark}$}#1}


\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{.3}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.5}

\long\def\@makecaption#1#2{
  \vskip 10truept 
  \setbox\@tempboxa\hbox{#1 : #2}
  \ifdim \wd\@tempboxa >\hsize \unhbox\@tempboxa\par \else \hbox
  to\hsize{\hfil\box\@tempboxa\hfil} 
  \fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 図表の番号の設定

%\newcounter{figure}[chapter]
\def\thefigure{\thechapter.\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{Fig. \thefigure}
\def\figure{\@float{figure}}
\let\endfigure\end@float
\@namedef{figure*}{\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}
%\newcounter{table}[chapter]
\def\thetable{\thechapter.\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{Table \thetable}
\def\table{\@float{table}}
\let\endtable\end@float
\@namedef{table*}{\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}

%\input titlepage.sty


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 表紙

\newlength{\titletopskip}
\setlength{\titletopskip}{4.0truecm}


\def\maketitle{%
\begin{titlepage} 
  %\let\footnotesize\small
  \let\footnoterule\relax \setcounter{page}{0}
  \null
  \vspace{-15truemm}
  \centerline{\LARGE 令和 \@defensejyear \ 年度　{\LARGE\thesistitle}}
  
  \vspace{20.74pt}

  \hspace{-20.74pt}
  \hspace{-20.74pt}
  \LARGE 主論文
  \vspace{20.74pt}
  \vspace{20.74pt}

  \hspace{-20.74pt}
  \hspace{-20.74pt}
  %% \LARGE \underline{（題名）\LARGE\textbf{\@title}}
  \LARGE {\@title}
  \vspace{20.74pt}
  \vspace{20.74pt}
  \vspace{20.74pt}
  %% \vspace{20.74pt}
  
  %% \hspace{20.74pt}
  %% \hspace{20.74pt}
  \hspace{-20.74pt}
  \hspace{-20.74pt}
  \LARGE \@major
  \vspace{20.74pt}
  
  %% \hspace{20.74pt}
  %% \hspace{20.74pt}
  \hspace{-20.74pt}
  \hspace{-20.74pt}
  \LARGE 令和\ \@enteryear\ 年度入学
  \vspace{20.74pt}
  \vspace{20.74pt}
  
  %% \hspace{20.74pt}
  %% \hspace{20.74pt}
  \hspace{-20.74pt}
  \hspace{-20.74pt}
  \LARGE 氏　　名 \quad \@author
  \vspace{20.74pt}
  \vspace{20.74pt}
  
  %% \hspace{20.74pt}
  %% \hspace{20.74pt}
  \hspace{-20.74pt}
  \hspace{-20.74pt}
  \LARGE 指導教員 \quad \@advisername
  %% \begin{tabular}{lll} %% added by K.Abiko 2009/01/12
  %%   {\LARGE 指導教員\quad} &
  %%   {\LARGE \@advisername} & 
  %%   {\LARGE \@advisertitle}\\
  %% \end{tabular}
  \vskip 20truept

  
  
  \vfill
  \rightline{\LARGE \@date 提出}
  \hspace{-20.74pt}
  
  %% \begin{center}
  %%   \includegraphics[scale=0.1]{\@symbol} \par 
  %% \end{center}
  \rightline{\includegraphics[scale=0.6]{\@symbol}}
  {
    \renewcommand{\thefootnote}{}
    \footnote{Copyright \copyright\ \number\year\ by \@eauthor}
    \clearpage
    \footnote{%
      \begin{center}
        \copyright \number\year
        \par  \@eauthor
        \par  All rights reserved
        %% \par This thesis was written by typesetting software 
        %% \LaTeX
    \end{center}}
    \thispagestyle{empty}
  }
  
  %% % \vskip \titletopskip % \vfil
 %%  \vspace{-15truemm}
 %%  \centerline{\Large 令和 \@defensejyear \ 年度　{\Large\thesistitle}}\par
 %%  \vskip 30truept
 %%  {\Large 主論文}\par
 %%  \vskip 10truept
 %%  {\underline{\LARGE （題名）\LARGE\textbf{\@title}} \par}
 %%  %% \vskip 15truept
 %%  %% {\large\textbf{\@etitle} \par}
 %%  \@thanks
 %%  \vfil
 %%  \vfil
 %%  \vfil
 %%  \begin{center}
 %%    \includegraphics[scale=0.3]{\@symbol} \par 
 %%  \end{center}
 %%  \vfil
 %%  \vfil
 %%  \vfil
 %%  \vfil
 %%  \par
 %%  %% %\vspace{8truemm}
 %%  %% %\vfil
 %%  %% %\vfil
 %%  %% %{\Large \@school} \par
 %%  %% \hspace{20.74pt}
 %%  %% \hspace{20.74pt}
 %%  {\LARGE \@major} \par
 %%  %% \vskip 20truept
 %%  %% {\large 学籍番号} \ \ {\large \@identify} \parindent
 %%  \vskip 20truept
 %%  %% \hspace{20.74pt}
 %%  %% \hspace{20.74pt}
 %%  {\LARGE 平成\ \@enteryear\ 年度入学}
 %%  \vskip 20truept
 %%  %% \hspace{20.74pt}
 %%  %% \hspace{20.74pt}
 %%  {\LARGE 氏　　名 \quad \@author} \par
 %%  \vskip 20truept
 %%  %% \hspace{20.74pt}
 %%  %% \hspace{20.74pt}
 %%  \begin{tabular}{lll} %% added by K.Abiko 2009/01/12
 %%    {\LARGE 指導教員\quad} &
 %%    {\LARGE \@advisername} & 
 %%    {\LARGE \@advisertitle}\\
 %%  \end{tabular}
 %%  \vskip 20truept
  
 
 %% \rightline{{\LARGE \@date 提出} \par}

 %% {
 %% \renewcommand{\thefootnote}{}
 %% \footnote{Copyright \copyright\ \number\year\ by \@eauthor}
 %% \clearpage
 %% \footnote{%
 %% \begin{center}
 %%  \copyright \number\year
 %%  \par  \@eauthor
 %%  \par  All rights reserved
 %%  %% \par This thesis was written by typesetting software 
 %%  %% \LaTeX
 %% \end{center}}
 %% \thispagestyle{empty}
 %% }
 \null
\end{titlepage}

\setcounter{footnote}{0} 
\let\thanks\relax
\gdef\@thanks{}
%\gdef\@author{}
\gdef\@title{}
\gdef\thesistitle{}
\let\maketitle\relax
} 

%% \newlength{\titletopskip}
%% \setlength{\titletopskip}{4.0truecm}



%% \def\maketitle{%
%% \begin{titlepage} 
%%  %\let\footnotesize\small
%%  \let\footnoterule\relax \setcounter{page}{0}
%%  \null
%%  % \vskip \titletopskip % \vfil
%%  \vspace{-5truemm}
%%  \begin{center}
%%   {\LARGE \thesistitle} \par
%%   \vskip 30truept
%%   {\huge\textbf{\@title} \par}
%%   \vskip 15truept
%%   {\large\textbf{\@etitle} \par}
%%   \vskip 40truept
%%   \begin{tabular}{cll} %% added by K.Abiko 2009/01/12
%%    {\Large 指導教員} & 
%%    {\Large \@advisername} & 
%%    {\Large \@advisertitle}\\
%%    % & {\Large \@subadvisername} & {\Large \@subadvisertitle}\\
%%   \end{tabular}
%%   %{\Large 指導教員} \ \ {\Large \@adviser} 
%%  \end{center} \par
%%  \@thanks
%%  \vfil
%%  \vfil
%%  \vfil
%%  \vfil
%%  \vfil
%%  %\vspace{55truemm}
%%  \vspace{43truemm}
%%  %\vfil
%%  %\vfil
%%  \begin{center}
%%   %\scalebox{0.3}{\includegraphics{hata.eps}} \par
%%   {\Large \@school} \par 
%%   {\large \@major}  \par
%%   \vskip 20truept
%%   {\large 学籍番号} \ \ {\large \@identify} \par
%%   \vskip 20truept
%%   {\LARGE \@author} \par
%%   \vskip 20truept
%%   {\large \@date} \par
%%  \end{center}
%%  {
%%  \renewcommand{\thefootnote}{}
%%  \footnote{Copyright \copyright\ \number\year\ by \@eauthor}
%%  \clearpage
%%  \footnote{%
%%  \begin{center}
%%   \copyright \number\year 
%%   %% \\  \@eauthor 
%%   %% \\  All rights reserved 
%%   %% \\ This thesis was written by typesetting software 
%%   %% \LaTeX
%%   \par  \@eauthor
%%   \par  All rights reserved
%%   %% \par This thesis was written by typesetting software 
%%   %% \LaTeX
%%  \end{center}}
%%  \thispagestyle{empty}
%%  }
%%  \null
%% \end{titlepage}

%% \setcounter{footnote}{0} 
%% \let\thanks\relax
%% \gdef\@thanks{}
%% %\gdef\@author{}
%% \gdef\@title{}
%% \gdef\thesistitle{}
%% \let\maketitle\relax
%% } 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 概要

\def\abstractname{概\ 要}

\def\abstract{\titlepage \setcounter{page}{1} \pagestyle{empty}
  \begin{center}
    {\textbf{\abstractname}}
  \end{center}}
\def\endabstract{\par\vfil\null\endtitlepage}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% 英語概要

%% \def\eabstract{\titlepage \setcounter{page}{1} \pagestyle{empty}%\vspace{-10truemm}
%%   \vspace{-15truemm}
%%   \begin{flushright}
%%     {{\it \@edate}}
%%   \end{flushright}
%%   \begin{center}
%%    {\large\textbf{\@etitle} \par}
%%    \vspace{3truemm}
%%    {\it Thesis by \par \it \@identify ~ \@eauthor \par}
%%    \null
%%    {\textbf{\eabstractname}}
%% \end{center}}
%% \def\endeabstract{\par\vfil\null\endtitlepage}

\def\eabstractname{Abstract}

\def\eabstract{\titlepage \setcounter{page}{1} \pagestyle{empty}
  %% Very Simple Style:
  %% \begin{center}
  %%   {\large\textbf{\eabstractname}}
  %% \end{center}}

  %% CSL Modified Style:
  %% \vspace{-15truemm}
  \begin{flushright}
    {{\@edate}}
  \end{flushright}
  \begin{center}
    {\large\textbf{\@etitle} \par}
    \vspace{3truemm}
    {by \par No.\@identify \par {\textbf{\@eauthor}} \par}
    \null
    {\textbf{\eabstractname}}
  \end{center}}

  %% General Style:
  %% \begin{center}
  %%   {\large\textbf{\eabstractname} \par}
  %%   \null
  %%   {\large\textbf{\@etitle} \par}
  %%   \vspace{2truemm}
  %%   {by \par}
  %%   \vspace{2truemm}
  %%   {\textbf{\large\@eauthor} \par \@emajor, \par \@eschool \par}
  %%   \vspace{5truemm}
  %% \end{center}}
\def\endeabstract{\par\vfil\null\endtitlepage}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% ユーザがパラメータを入力する関数の定義

%% \def\school#1{\def\@school{#1}}
%% \def\major#1{\def\@major{#1}}
%% \def\identify#1{\def\@identify{#1}}
%% \def\adviser#1#2{\def\@advisername{#1}\def\@advisertitle{#2}} %% added by K.Abiko 2009/01/12
%% \def\subadviser#1#2{\def\@subadvisername{#1}\def\@subadvisertitle{#2}} %% added by K.Abiko 2009/01/12
%% \def\eauthor#1{\def\@eauthor{#1}}
%% \def\etitle#1{\def\@etitle{#1}}
%% \def\edate#1{\def\@edate{#1}} %% added by K.Abiko 2009/01/30

%% \def\crnotify#1{\def\@crnotify{#1}}
%% \crnotify{}


%% \mark{{}{}}

\def\school#1{\def\@school{#1}}
\def\eschool#1{\def\@eschool{#1}}
\def\major#1{\def\@major{#1}}
\def\emajor#1{\def\@emajor{#1}}
\def\identify#1{\def\@identify{#1}}
\def\adviser#1{\def\@advisername{#1}} 
%% \def\adviser#1#2{\def\@advisername{#1}\def\@advisertitle{#2}} %% added by K.Abiko 2009/01/12
\def\subadviser#1#2{\def\@subadvisername{#1}\def\@subadvisertitle{#2}} %% added by K.Abiko 2009/01/12
\def\eauthor#1{\def\@eauthor{#1}}
\def\etitle#1{\def\@etitle{#1}}
\def\symbol#1{\def\@symbol{#1}}
\def\edate#1{\def\@edate{#1}} %% added by K.Abiko 2009/01/30
\def\enteryear#1{\def\@enteryear{#1}}
\def\defensejyear#1{\def\@defensejyear{#1}}


\def\crnotify#1{\def\@crnotify{#1}}
\crnotify{}


\mark{{}{}} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%%%%% twoside オプションに対する設定

\if@twoside 
\def\ps@headings{\let\@mkboth\markboth
  \def\@oddfoot{}
  \def\@evenfoot{}
  \def\@evenhead{\rm\thepage \hfil \sl \leftmark}
  \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
  \def\chaptermark##1{\markboth 
    {\uppercase{\ifnum \c@secnumdepth >\m@ne
        第\ \thechapter \ 章 \ \fi ##1}}{}}\def\sectionmark##1{\markright
    {\uppercase{\ifnum \c@secnumdepth >\z@
        \thesection. \ \fi ##1}}}}
\else 
\def\ps@headings{\let\@mkboth\markboth
  \def\@oddfoot{}
  \def\@evenfoot{}
  \def\@oddhead{\hbox {}\sl \rightmark \hfil \rm\thepage}
  \def\chaptermark##1{\markright 
    {\uppercase{\ifnum \c@secnumdepth >\m@ne
        第\ \thechapter \ 章 \ \fi ##1}}}}
\fi

\def\ps@myheadings{\let\@mkboth\@gobbletwo
  \def\@oddhead{\hbox{}\sl\rightmark \hfil \rm\thepage}
  \def\@oddfoot{}
  \def\@evenhead{\rm \thepage\hfil\sl\leftmark\hbox{}}
  \def\@evenfoot{}\def\chaptermark##1{}%
  \def\sectionmark##1{}\def\subsectionmark##1{}}


\newif\if西暦\let\if西暦=\iffalse \def\西暦{\let\if西暦=\iftrue}
\def\today{{\if西暦\count0=\year\else%
    \count0=\year\advance\count0 -1988 平成\,\fi%
    \ifnum\count0=1 元\else\number\count0\fi\,年\hspace{.5em}\nobreak%
    \number\month\,月\hspace{.5em}\nobreak\number\day\,日}}
\@addtoreset{equation}{chapter} 
\def\theequation{\thechapter.\arabic{equation}}


\ps@plain \pagenumbering{arabic} \onecolumn \if@twoside\else\raggedbottom\fi 
%
%
%  行間を開ける
%
%\renewcommand{\baselinestretch}{1.3}
\renewcommand{\baselinestretch}{1.2}
%

%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 謝辞

%% \newenvironment{acknowledgement}[2][\西暦 \today]
%% {%
%%   \setcounter{chapter}{0}
%%  \addcontentsline{toc}{chapter}{謝辞}
%%   \def\@ackdate{#1}%
%%   \chapter*{謝辞\@mkboth{謝辞}{謝辞}} %
%%   #2%
%%   \thispagestyle{fancy}%
%% }%
%% { \begin{flushright}%
%%     \vskip 1em \@ackdate \\ \@author 
%%   \end{flushright}%
%% }

\newenvironment{acknowledgement}[2][\西暦 \today]
{%
  \setcounter{chapter}{0}
  \addcontentsline{toc}{chapter}{謝辞}
  \def\@ackdate{#1}%
  \chapter*{謝辞\@mkboth{謝辞}{謝辞}} %
  #2%
  \thispagestyle{fancy}%
}%
{ \begin{flushright}%
    \vskip 1em \@ackdate
    %% \par \@author 
  \end{flushright}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ヘッダ

\usepackage{fancyhdr}
\pagestyle{fancyplain}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter~\ #1}{\thechapter~\ #1}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
\lhead[\fancyplain{}{\thepage}]{\fancyplain{}{}}
\rhead[\fancyplain{}{}]{\fancyplain{}{\thepage}}
\chead[\fancyplain{}{\leftmark}]{\fancyplain{}{\rightmark}}
\cfoot[]{}
