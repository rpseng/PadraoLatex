%%
%% Classe para teses e dissertações do PPGEQ
%% Rafael de Pelegrini Soares (rafael@enq.ufrgs.br) Abril de 2014
%%
%% Autores do padrão PPGEQ para LaTeX (ppgeq.cls):
%%  Melhorias em abril de 2014:
%%   - Rafael de Pelegrini Soares (rafael@enq.ufrgs.br)
%%  Melhorias em julho de 2012:
%%   - Rafael de Pelegrini Soares (rafael@enq.ufrgs.br)
%%  Melhorias em março de 2012:
%%   - Rafael de Pelegrini Soares (rafael@enq.ufrgs.br)
%%  Melhorias em março de 2009:
%%   - Gerson Bicca (bicca@enq.ufrgs.br)
%%   - Jovani Luiz Favero (favero@enq.ufrgs.br)
%%   - Paula Bettio Staudt (paula@enq.ufrgs.br)
%% Versão de fevereiro de 2006:
%%  - Rafael de Pelegrini Soares (rafael@rps.eng.br)
%%
%% Este arquivo é baseado na classe `abntex2.cls':
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{ppgeq}[2014/04/21 ppgeq]
 
%
% Repassa todos os parâmetros à memoir
%
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}%
}
\ProcessOptions\relax
\LoadClass[12pt,a4paper]{memoir}

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Pacotes e customizações gerais
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ---
% Hifenação e caracteres especiais
% português-brasil e inglês
% ---
\usepackage[brazil]{babel}
\addto\captionsbrazil{%
%  \renewcommand{\listfigurename}{Lista de Ilustra\c{c}\~{o}es}
}
\renewcommand{\cftfigurename}{\figurename\space} 
\renewcommand{\cfttablename}{\tablename\space} 
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}

\usepackage{listings}	% Pacote para linguagens
\let\oldlstlistoflistings\lstlistoflistings
\renewcommand{\lstlistoflistings}{%
  \begingroup%
  \let\oldnumberline\numberline%
  \renewcommand{\numberline}{\lstlistingname~\oldnumberline}%
  \oldlstlistoflistings%
  \endgroup}
  
\usepackage[brazil]{hyperref}
%PDF LaTeX
\newif\ifpdf
\ifx\pdfoutput\undefined
  \pdffalse
\else
  \pdfoutput=1
  \pdftrue
\fi
\usepackage{bookmark}

% pacote padrao ABNT para bibliografia
\usepackage[alf, bibjustif, abnt-etal-cite=2, abnt-etal-list=0]{abntcite}
\bibliographystyle{abnt-alf}
% pacote para lista de simbolos
\usepackage[portuguese]{nomencl}
\def\nomname{Lista de Símbolos}
\makenomenclature
 
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\newif\if@mainmatter \@mainmattertrue
\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}

%% PPGEQ
\newif\ifqualify
\qualifyfalse
\DeclareOption{mestrado}
	{\providecommand{\thecategory}{Disserta\c{c}\~ao}
	\providecommand{\thecategorylevel}{Mestrado}
	\providecommand{\thecategorytitle}{Mestre em Engenharia Qu\'{i}mica}}
\DeclareOption{doutorado}
	{\providecommand{\thecategory}{Tese}
	\providecommand{\thecategorylevel}{Doutorado}
	\providecommand{\thecategorytitle}{Doutor em Engenharia Qu\'{i}mica}}
\DeclareOption{qualify}
	{\providecommand{\thecategory}{Exame}
	\providecommand{\thecategorylevel}{Qualifica\c{c}\~ao ao Doutorado}
	\providecommand{\thecategorytitle}{Doutor em Engenharia Qu\'{i}mica}
	\qualifytrue}

\newcommand{\insertcodelist}{}
\DeclareOption{codelist}{
\renewcommand{\insertcodelist}{\clearpage \lstlistoflistings}
}

\ProcessOptions

%+++++++++++++++++++++++++++++++++++++++ Lista de Símbolos ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\usepackage{siunitx}
\renewcommand\nomgroup[1]{%
  \ifthenelse{\equal{#1}{A}}{%
   \item[\textbf{}] }{%             A - Romanas
    \ifthenelse{\equal{#1}{G}}{\vspace{1cm}
     \item[\textbf{Letras Gregas}]}{%             G - Gregas
      \ifthenelse{\equal{#1}{R}}{\vspace{1cm}%
        \item[\textbf{Sobrescritos}]}{%           R - Sobrescritos
          \ifthenelse{\equal{#1}{S}}{\vspace{1cm}%
           \item[\textbf{Subescritos}]}{%             S - Subescritos
        \ifthenelse{\equal{#1}{X}}{\vspace{1cm}%
         \item[\textbf{Outros Símbolos}]}{%    X - Outros Símbolos
        \ifthenelse{\equal{#1}{Z}}{\vspace{1cm}%
         \item[\textbf{Siglas}]}%              Z - Siglas
                        {{}}}}}}}}
\newcommand{\nomunit}[1]{%
\renewcommand{\nomentryend}{\hspace*{\fill}\si{#1}}}

% margens laterais ajustadas para ABNT: 3cm na esquerda e 2cm direita
% 3cm - 1in = 4.6mm e 1in - 3cm = -5.4mm
\oddsidemargin 4.6mm \evensidemargin -5.4mm
\textwidth     160mm
% margens superior e inferior para ABNT: 3cm superior e 2cm inferiror MUITO GRANDE!!!
% a principio nao está de acordo com a norma ABNT
\topmargin     -5.4mm
\textheight    235mm

\thicklines   % para a linha ficar grossa nas figuras
%\setlength{\textfloatsep}{1.5\textfloatsep}
\setlength{\intextsep}{1.5\intextsep}

% pacote para testes e programação
\usepackage{xifthen}

% Comandos para construir as primeiras paginas com 'maketitle'
\renewcommand{\title}[1]{\newcommand{\thetitle}{#1}}
\renewcommand{\author}[1]{\newcommand{\theauthor}{#1}}
\newcommand{\authorCitation}[1]{\newcommand{\theauthorCitation}{#1}}
\newcommand{\area}[1]{\newcommand{\thearea}{#1}}
\newcommand{\tyear}[1]{\newcommand{\theyear}{#1}}
\newcommand{\advisor}[1]{\newcommand{\theadvisor}{#1}}
\newcommand{\advisorCitation}[1]{\newcommand{\theadvisorCitation}{#1}}
\newcommand{\thecoadvisor}{}
\newcommand{\coadvisor}[1]{\renewcommand{\thecoadvisor}{#1}}
\newcommand{\coadvisorCitation}[1]{\newcommand{\thecoadvisorCitation}{#1}}
%\newcommand{\coadvisor}[1]{\renewcommand{\thecoadvisor}{Colaborador: \\ #1 \\*}}
\newcommand{\totalPages}[1]{\newcommand{\thetotalPages}{#1}}
\newcommand{\bancai}[1]{\newcommand{\thebancai}{#1}}
\newcommand{\bancaii}[1]{\newcommand{\thebancaii}{#1}}
\newcommand{\bancaiii}[1]{\newcommand{\thebancaiii}{#1}}
\newcommand{\thebancaiiii}{}
\newcommand{\bancaiiii}[1]{\renewcommand{\thebancaiiii}{#1}}
\newcommand{\pensamento}[1]{\newcommand{\thepensamento}{#1}}
\newcommand{\resumo}[1]{\newcommand{\theresumo}{#1}}
\newcommand{\palavraschave}[1]{\newcommand{\thepalavras}{#1}}
\renewcommand{\abstract}[1]{\newcommand{\theabstract}{#1}}
\newcommand{\keywords}[1]{\newcommand{\thekeywords}{#1}}
\newcommand{\agradecimento}[1]{\newcommand{\theagradecimento}{#1}}

% o novo maketitlepage
\renewcommand{\maketitle}{
\parskip 4.3mm
\pdfbookmark[section]{Capa}{title}
\pagestyle{empty}
\pagenumbering{roman}
% Primeira página de título
\begin{center}
\textsc \large
Universidade Federal do Rio Grande do Sul \\
Escola de Engenharia \\
Departamento de Engenharia Química \\
Programa de Pós-Graduação em Engenharia Química
\vfill \vfill
\Large \bfseries \textsc \thetitle
\vfill \vfill
\large \textsc \thecategory{} de \thecategorylevel
\vfill
\large \bfseries \textsc \theauthor
\vfill
\large \textsc Porto Alegre, RS \\ \theyear
\end{center}
\cleardoublepage
% Página com a área de concentração e orientador
\begin{center}
\setcounter{page}{1}
\textsc \large
Universidade Federal do Rio Grande do Sul \\
Escola de Engenharia \\
Departamento de Engenharia Química \\
Programa de Pós-Graduação em Engenharia Química
\vfill \vfill
\Large \bfseries \textsc \thetitle
\vfill \vfill
\large \bfseries \textsc \theauthor
\end{center}
\vfill
\begin{flushright}
\begin{minipage}{100mm}
\ifqualify
Proposta de pesquisa para Tese de Doutorado (D.Sc.) apresentada como parte integrante
do Exame de Qualificação ao Doutorado no Programa de Pós-Graduação em Engenharia Química da UFRGS.
\else
\thecategory{} de \thecategorylevel{} apresentada como requisito parcial para
obtenção do título de \thecategorytitle.
\fi
\\*[2em]
Área de Concentração: \thearea \\*[2em]
\bfseries \textsf{
Orientador: \\ Prof.~\theadvisor \\*[1em]
\ifthenelse{\equal{\thecoadvisor}{}}{}{Coorientador:\\ Prof.~\thecoadvisor}
}
\end{minipage}
\end{flushright}
\vfill
\begin{center}
\large \bfseries \textsc Porto Alegre, RS \\ \theyear
\end{center}
\clearpage
% Ficha Catalográfica
\vfill
\vfill
\vspace*{12cm}
\begin{center}
\fbox{
\begin{minipage}{12cm}
\begin{center}
\begin{minipage}{11cm}
\ttfamily
\small
\vspace*{0.5cm}
\theauthorCitation \\
\hspace*{2em}\thetitle~/~\theauthor.~{-}{-}~\theyear. \\
\hspace*{2em}\thetotalPages~f.
\\ \\
\hspace*{2em}Orientador: \theadvisor \\
\ifthenelse{\isempty{\thecoadvisor}}{}{\hspace*{2em}Coorientador:~\thecoadvisor \\}
\\
\hspace*{2em}\thecategory{} (\thecategorylevel) - Universidade Federal do Rio Grande
do Sul, Escola de Engenharia, Programa de Pós-Graduação em Engenharia Química,
Porto Alegre, BR-RS, \theyear.
\\ \\
\hspace*{2em}\thepalavras~I.~\theadvisorCitation, orient.
%\ifthenelse{\equal{\thecoadvisor}{}}{}{Coorientador:\\ Prof.~\thecoadvisor}
\ifthenelse{\equal{\thecoadvisor}{}}{II.~Título.}{II.~\thecoadvisorCitation, coorient.~III.~Título.}
\vspace*{0.5cm}
\end{minipage}
\end{center}
\end{minipage}
}
\end{center}
\vfill
\clearpage
% Página com os membros da banca
\pagestyle{plain}
\begin{center}
\textsc \large
Universidade Federal do Rio Grande do Sul \\
Escola de Engenharia \\
Departamento de Engenharia Química \\
Programa de Pós-Graduação em Engenharia Química
\end{center}
\vfill \vfill \vfill
\ifqualify
A Comissão Examinadora, abaixo assinada, aprova a Proposta de Pesquisa
\emph{\thetitle}, elaborada por \theauthor{}
como parte integrante do Exame de Qualificação ao Doutorado.
\else
A Comissão Examinadora, abaixo assinada, aprova a \thecategory{}
\emph{\thetitle}, elaborada por \theauthor{}
como requisito parcial para obtenção do Grau de \thecategorytitle.
\fi
\vfill
{\raggedright Comissão Examinadora:} \\*[2em]
\begin{flushright}
{\small
\begin{tabular}{@{\hspace{10em}}c}
\hline \thebancai \\*[8ex]
\hline \thebancaii \\*[8ex]
\hline \thebancaiii \\*[8ex]
%\ifthenelse{\equals{\thebancaiiii}{}}{}{\hline \thebancaiiii \\*[8ex] }
\ifthenelse{\equal{\thebancaiiii}{}}{}{\hline Teste}
\end{tabular}
}
\end{flushright}
\vfill
\cleardoublepage

\ifqualify
\else
% Página do pensamento
\vspace*{10em}
\begin{center}
{\large \it \thepensamento}
\end{center}
\cleardoublepage
% Página dos agradecimentos
\chapter*{Agradecimentos}
\theagradecimento
\cleardoublepage
\fi

% Página do resumo
\pdfbookmark[section]{Resumo}{resumo}
\chapter*{Resumo}
\theresumo \\*[2em] \textbf{Palavras-chave: \thepalavras}
\cleardoublepage
% Página do abstract
%\language 1
\pdfbookmark[section]{Abstract}{abstract}
\chapter*{Abstract}
\theabstract \\*[2em] \textbf{Key-words: \thekeywords}
%\language 0
\cleardoublepage

\begin{KeepFromToc}
  \pdfbookmark[section]{\contentsname}{toc}
  \tableofcontents
\end{KeepFromToc}
\clearpage \listoffigures	
\clearpage \listoftables
\insertcodelist
\clearpage \printnomenclature[0.8in]\addcontentsline{toc}{chapter}{\nomname}\

% configurações padrão
\cleardoublepage
\baselineskip 7mm
\parskip 5mm
\parindent 12mm
\pagestyle{fancy}
\headheight 15pt
\pagenumbering{arabic}
} % end maketitle

% ------------------------------------------------------------------------------
% Fonts
% ------------------------------------------------------------------------------
%\usepackage{lmodern}
\usepackage{palatino}
\renewcommand{\textsc}[1]{\fontshape{sc} \fontfamily{\sfdefault} \selectfont #1}
% chapter fonts
\renewcommand*{\chapnumfont}{\normalfont\HUGE\bfseries\sffamily}
\renewcommand*{\chaptitlefont}{\chapnumfont}
\renewcommand*{\chapnamefont}{\chapnumfont}
\renewcommand*{\printchapternum}{\chapnumfont \thechapter\space}
\renewcommand{\cftchapterfont}{\normalfont\bfseries\sffamily}   
\renewcommand{\cftsectionfont}{\normalfont}
\renewcommand{\cftsubsectionfont}{\normalfont}

\usepackage{titlesec}
\titleformat*{\section}{\sffamily\Large\bfseries}
\titleformat*{\subsection}{\sffamily\large\bfseries}
\titleformat*{\subsubsection}{\sffamily\large}

% ------------------------------------------------------------------------------
% Headings
% ------------------------------------------------------------------------------
\let\footruleskip\undefined
\usepackage{fancyhdr}
\fancyhf{}
\fancyhead[LE, RO]{\textsc \thepage}
\fancyhead[RE]{\textsc \nouppercase \leftmark}
\fancyhead[LO]{\textsc \nouppercase \rightmark}

\renewcommand{\bf}{\textbf}
\renewcommand{\it}{\textit}

\usepackage{subfig}            %
\newcommand{\subfigref}[1]{\hyperref[#1]{Figura~\ref*{#1}}}
\usepackage{longtable}         % Special tables
\usepackage{array}             % Tables formatings
%\usepackage{dcolumn}          % Decimal tabulator
\usepackage{float}             % Positioner, Formater (H-Option)
%\usepackage{floatflt}         % umfliessender Text
%\usepackage[bf,small]{caption} % variable Beschriftung von Gleitobjekten
%\usepackage[notref,notcite]{showkeys}  % Anzeige von label-, ref-, cite- und
                                        % bib-keys

% ------------------------------------------------------------------------------
%PDF Customizaçoes
% ------------------------------------------------------------------------------
\AtBeginDocument{
\hypersetup{
    bookmarks=true,         % show bookmarks bar?
   % unicode=false,          % non-Latin characters in Acrobat?s bookmarks
    pdftoolbar=true,        % show Acrobat?s toolbar?
    pdfmenubar=true,        % show Acrobat?s menu?
    pdffitwindow=false,     % window fit to page when opened
    pdfstartview={FitH},    % fits the width of the page to the window
    pdftitle={\thetitle},    % title
    pdfauthor={\theauthor},     % author
    pdfsubject={\thecategory\ de \thecategorylevel},   % subject of the document
    pdfcreator={PDFLaTex},   % creator of the document
    pdfproducer={PPGEQ - Programa de Pós Graduação em Engenharia Química, UFRGS}, % producer of the document
    pdfkeywords={\thepalavras}, % list of keywords
    pdfnewwindow=true,      % links in new window
    colorlinks=false,       % false: boxed links; true: colored links
    linkcolor=red,          % color of internal links
    citecolor=green,        % color of links to bibliography
    filecolor=magenta,      % color of file links
    urlcolor=cyan           % color of external links
}
}
% ------------------------------------------------------------------------------
% AMS-Package
% ------------------------------------------------------------------------------
\usepackage{amsmath}   % Base package
\usepackage{amssymb}   % Symbols of AMS-Fonts
\usepackage{amscd}     % Commutative Diagram

\endinput
