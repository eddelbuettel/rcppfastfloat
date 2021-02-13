library(RcppFastFloat)
library(microbenchmark)

set.seed(8675309)
input <- sample(c(paste0(" \r\n\t\f\v", c(0.0, sqrt(seq(1, 10))), " \r\n\t\f\v"),
                  c("NaN", "-NaN", "nan", "-nan",
                    "Inf", "-Inf", "inf", "-inf", "infinity", "-infinity",
                    NA_character_,
                    "  1970-01-01", "1970-01-02  ")
                  ))
str(input)

## NA conversion triggers warnings we explicitly suppress here
op <- options(warn=-1)

stopifnot(all.equal(as.double(input), as.double2(input)))

microbenchmark(baseR=as.double(input),
               fastfloat=as.double2(input),
               times=500)

## reset
options(op)
