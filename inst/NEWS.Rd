\name{NEWS}
\title{News for Package \pkg{RcppFastFloat}}
\newcommand{\ghpr}{\href{https://github.com/eddelbuettel/rcppfastfloat/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/eddelbuettel/rcppfastfloat/issues/#1}{##1}}

\section{Changes in version 0.0.5 (2025-01-15)}{
  \itemize{
    \item No longer set a compilation standard
    \item Updates to continuous integration, badges, URLs, DESCRIPTION
    \item Update to \pkg{fast_float} 7.0.0
    \item Per CRAN Policy comment-out compiler 'diagnostic ignore' instances 
  }
}

\section{Changes in version 0.0.4 (2023-01-20)}{
  \itemize{
    \item Update to \pkg{fast_float} 3.9.0
    \item Set two \code{#define} re-establish prior behaviour with respect to
    whitespace removal prior to parsing for \code{as.double2()}
    \item Small update to continuous integration actions
  }
}

\section{Changes in version 0.0.3 (2021-08-21)}{
  \itemize{
    \item Account for SunOS with an additional \code{#define}
    \item Minor update to \code{DESCRIPTION}
  }
}

\section{Changes in version 0.0.2 (2021-02-13)}{
  \itemize{
    \item New function \code{as.double2()} demonstrating
    \code{fast_float} (Brendan in \ghpr{1}) 
  }
}

\section{Changes in version 0.0.1 (2021-01-31)}{
  \itemize{
    \item Initial version and CRAN upload
  }
}

