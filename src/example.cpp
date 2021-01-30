#define STRICT_R_HEADERS
#include <Rcpp.h>

#include "fast_float/fast_float.h"

//' Floating Point Parsing Example
//'
//' This example is adapted from the example of the upstream README.md file, and generalized
//' to be called from R with variable input.
//'
//' @param input A character variable with text to parse including a simple default
//' @param verbose A boolean variable to show or suppress progress, defaults to true
//' @return A floating point scalar is returned on success; in case of parsing failure
//' the function exists via \code{stop()}.
//' @examples
//' parseExample()
// [[Rcpp::export]]
double parseExample(const std::string & input = "3.1416 xyz ", bool verbose = true) {
    double result;
    auto answer = fast_float::from_chars(input.data(), input.data()+input.size(), result);
    if (answer.ec != std::errc()) Rcpp::stop("parsing failure");
    if (verbose) Rcpp::Rcout << "parsed the number " << result << std::endl;
    return result;
}
