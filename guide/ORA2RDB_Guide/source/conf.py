# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

latex_use_latex_multicolumn = True

project = 'ORA2RDB_Guide'
copyright = '2022, Red Soft'
author = 'Red Soft'

# General configuration

import re
import os
import sys
sys.path.append(os.path.abspath("./_ext"))


# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ['sphinx_design', 'UnindentedListDirective', 'NewCodeBlockDirective', 'sphinxnotes.comboroles']

#f = open('defs.tex.txt', 'r+');
#PREAMBLE = f.read();

smartquotes = False

templates_path = ['_templates']
exclude_patterns = []

language = 'ru'

latex_additional_files = ["defs.sty"]

latex_engine = 'pdflatex'

latex_toplevel_sectioning = 'section'

latex_documents = [
 ('index', 'ORA2RDB_Guide.tex', u'Ред База Данных', u'YourName', 'article'),
]

latex_elements = {
'passoptionstopackages' : r'''
    \PassOptionsToPackage{pdftex}{graphicx}
    \PassOptionsToPackage{numbered}{bookmark}
    \PassOptionsToPackage{tikz}{bclogo}
    ''',
'fontenc' : r'''
    \usepackage[T2A]{fontenc}
    ''',
'fontsubstitution' : r'',
'inputenc' : r'\usepackage[utf8]{inputenc}',
'preamble': r"""
\usepackage{defs}
""",
'hyperref' : r'''
\usepackage[colorlinks=true,linkcolor=blue]{hyperref}
''',
'maketitle': r"""
\nonstopmode

\thispagestyle{empty}
\begin{titlepage}
\renewcommand{\maketitle}{ O{\ } O{\ } m }{
\fancyhf{}
\thispagestyle{empty}

\topskip0pt
\vspace*{\fill}

\begin{flushright}
\Huge {\xhrulefill{red}{2mm}\color{red} Ред} База Данных\\
\LARGE \   \\
\huge Руководство пользователя\\
\huge конвертера метаданных Ora2rdb\\


\end{flushright}

\vspace*{\fill}}
\end{titlepage}
""",
'tableofcontents' : r"""
\addtocounter{page}{1}

\definecolor{MidnightBlue}{RGB}{25, 25, 112}

\titleformat{\section}[display]
{\filcenter\Huge\bfseries\color{MidnightBlue}}
{\raggedright\normalfont\Large Глава \thesection}{3pt}{}

\titleformat{\subsection}
{\filright\LARGE\bfseries\color{MidnightBlue}}
{\thesubsection}{10pt}{}

\titleformat{\subsubsection}
{\filright\Large\bfseries\color{MidnightBlue}}
{\thesubsubsection}{10pt}{}

\titleformat{\paragraph}
{\filright\large\bfseries\color{MidnightBlue}}
{\theparagraph}{1em}{}

\renewcommand{\thetable}{\thesection.\arabic{table}}
\renewcommand{\thefigure}{\thesection.\arabic{figure}}
\renewcommand{\sectionmark}[1]{\markright{\thesection~~~#1}}

\makeatletter
\fancypagestyle{normal}{
\pagestyle{fancy}
\fancyhf{}
\fancyhead[R]{Руководство пользователя Ora2rdb\\\rightmark}
\fancyfoot[C]{\xhrulefill{red}{2mm} Стр. \thepage}
\renewcommand{\headrulewidth}{0.5pt}
}
\makeatother

\setcounter{tocdepth}{10}
\setlength{\headheight}{24pt}
\renewcommand\contentsname{Содержание}
\tableofcontents
""",
'figure_align': 'H',
}

latex_table_style = []

numfig = True  #  чтобы :numref: не игнорировался
highlight_language = 'none'  # подсветка синтаксиса в код-блоках по умолчанию выключена


#latex_show_urls = 'footnote'
# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'alabaster'
html_static_path = ['_static']
html_css_files = [
    'css/codeblock_style.css',
]

comboroles_roles = {
    'ess': ['emphasis','strong'],
}

rst_prolog = """
.. |securityversion| replace:: ``security5.fdb``
.. |rdbversion| replace:: 5.0
.. role:: raw-latex(raw)
   :format: latex
"""
