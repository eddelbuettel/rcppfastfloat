library(RcppFastFloat)

expect_equal(parseExample("3.1416 xyz", FALSE), 3.1416)
expect_error(parseExample("abc 3.1416 xyz"))
expect_error(parseExample("abc xyz"))
