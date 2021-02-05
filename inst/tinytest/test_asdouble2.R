library(RcppFastFloat)

set.seed(8675309)
input <- sample(c(
  paste0(" \r\n\t\f\v", c(0.0, sqrt(seq(1, 10))), " \r\n\t\f\v"),
  c("NaN", "-NaN", "nan", "-nan",
    "Inf", "-Inf", "inf", "-inf", "infinity", "-infinity",
    NA_character_,
    "  1970-01-01", "1970-01-02  ")
))

expect_equal(suppressWarnings(as.double(input)),
             suppressWarnings(as.double2(input)))
