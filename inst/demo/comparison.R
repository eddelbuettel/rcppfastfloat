
library(RcppFastFloat)
library(microbenchmark)
library(Rcpp)

N <- 1e6
set.seed(42)          # does not matter but ensure sample() shuffle fixed
invec <- sample(sqrt(seq(1:N)))
input <- as.character(invec)

sourceCpp(code="
#include <Rcpp.h>
#include <fast_float/fast_float.h>

// [[Rcpp::depends(RcppFastFloat)]]

// [[Rcpp::export]]
void fastfloat(Rcpp::CharacterVector invec, Rcpp::NumericVector outvec) {
  size_t n = invec.size();
  for (size_t i=0; i<n; i++) {
    double d;
    std::string s(invec[i]);
    fast_float::from_chars(s.data(), s.data()+s.size(), d);
    outvec[i] = d;
  }
}

// [[Rcpp::export]]
void strtod(Rcpp::CharacterVector invec, Rcpp::NumericVector outvec) {
  size_t n = invec.size();
  for (size_t i=0; i<n; i++) {
    std::string s(invec[i]);
    outvec[i] = std::strtod(s.c_str(), NULL);
  }
}

// [[Rcpp::export]]
void atof(Rcpp::CharacterVector invec, Rcpp::NumericVector outvec) {
  size_t n = invec.size();
  for (size_t i=0; i<n; i++) {
    std::string s(invec[i]);
    outvec[i] = std::atof(s.c_str());
  }
}

// [[Rcpp::export]]
void sscanf(Rcpp::CharacterVector invec, Rcpp::NumericVector outvec) {
  size_t n = invec.size();
  for (size_t i=0; i<n; i++) {
    std::string s(invec[i]);
    double d;
    std::sscanf(s.c_str(), \"%lf\", &d);
    outvec[i] = d;
  }
}

// [[Rcpp::export]]
void stod(Rcpp::CharacterVector invec, Rcpp::NumericVector outvec) {
  size_t n = invec.size();
  for (size_t i=0; i<n; i++) {
    std::string s(invec[i]);
    outvec[i] = std::stod(s);
  }
}


")

outff <- double(N)
outst <- double(N)
outaf <- double(N)
outsf <- double(N)
outsd <- double(N)

res <- microbenchmark(scanf     = sscanf(input, outsf),
                      atof      = atof(input, outaf),
                      strtod    = strtod(input, outst),
                      stod      = stod(input, outsd),
                      fastfloat = fastfloat(input, outff))

## ensure correct parsing for all
stopifnot(`ff`=all.equal(invec,outff),
          `st`=all.equal(invec,outst),
          `af`=all.equal(invec,outaf),
          `sf`=all.equal(invec,outsf),
          `sd`=all.equal(invec,outsf))

print(res)
