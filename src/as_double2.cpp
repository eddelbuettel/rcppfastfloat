#define STRICT_R_HEADERS
#include <Rcpp.h>

#include "fast_float/fast_float.h"

/* essentially isBlankString(), but returns bool instead of Rboolean */
bool is_only_whitespace(const char *s) noexcept {
  while (*s) {
    if (!std::isspace(static_cast<unsigned char>(*s))) {
      return false;
    }
    ++s;
  }
  return true;
}

//' Ultra efficient string-to-\code{double} Conversion
//'
//' For \code{character} \code{vector}s, \code{as.double2()} is a
//' drop-in replacement for \code{base::as.double()}.
//'
//' @param x A vector of type \code{character}.
//'
//' @seealso \code{as.double()}
//'
//' @examples
//' set.seed(8675309)
//' input <- sample(c(
//'   paste0(" \r\n\t\f\v", c(0.0, sqrt(seq(1, 10))), " \r\n\t\f\v"),
//'   c("NaN", "-NaN", "nan", "-nan",
//'     "Inf", "-Inf", "inf", "-inf", "infinity", "-infinity",
//'     NA_character_,
//'     "  1970-01-01", "1970-01-02  ")
//' ))
//' input
//'
//' suppressWarnings(as.double2(input)) # NAs introduced by coercion
//'
//' comparison <- suppressWarnings(
//'   matrix(c(as.double(input), as.double2(input)),
//'          ncol = 2L,
//'          dimnames = list(NULL, c("as.double()", "as.double2()")))
//' )
//' comparison
//'
//' all.equal(comparison[, "as.double()"], comparison[, "as.double2()"])
//'
// [[Rcpp::export(as.double2)]]
Rcpp::DoubleVector
as_dbl(const Rcpp::CharacterVector x) {
  const auto n{x.size()};
  Rcpp::DoubleVector out(n, NA_REAL);
  bool any_failures{false};

  for (R_xlen_t i = 0; i < n; ++i) {
    const char *cstring = CHAR(x[i]);
    double d;
    const auto res = fast_float::from_chars(
        cstring, cstring + std::char_traits<char>::length(cstring), d);

    if (res.ec == std::errc() && is_only_whitespace(res.ptr)) {
      out[i] = d;
    } else {
      any_failures = true;
    }
  }

  if (any_failures) {
    Rcpp::warning("NAs introduced by coercion");
  }

  return out;
}
