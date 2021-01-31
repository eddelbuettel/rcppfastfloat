
## RcppFastFloat: Rcpp Bindings for the fastfloat C++ Header-Only Library

[![CI](https://github.com/eddelbuettel/rcppfastfloat/workflows/ci/badge.svg)](https://github.com/eddelbuettel/rcppfastfloat/actions?query=workflow%3Aci)
[![License](https://eddelbuettel.github.io/badges/GPL2+.svg)](https://www.gnu.org/licenses/gpl-2.0.html)
[![Last Commit](https://img.shields.io/github/last-commit/eddelbuettel/rcppfastfloat)](https://github.com/eddelbuettel/rcppfastfloat)

### Motivation

Converting ascii text into (floating-point) numeric values is a very common problem. The
[fast_float](https://github.com/fastfloat/fast_float) header-only C++ library by [Daniel
Lemire](https://lemire.me/en/) does this very well, and very fast at up to or over to 1 gigabyte per
second as described in more detail in a [recent arXiv paper](https://arxiv.org/abs/2101.11408).

This package brings this header-only library to R so that other R user can access it simply by
adding `LinkingTo: RcppFastFloat`.

### Example

A modified example function is included, try 

```r
library(RcppFastFloat)
exampleParse()
```

with default arguments or supply some.  We also include a [timing comparison in file
[benchmark/comparison.R](inst/benchmark/comparison.R) you can run just calling it from `Rscript`. On our
machine `fast_float` comes out as just over 3 times as fast as the next best alternative (and this
counts the function calls and all, so pure parsing speed is still a little bettter).

```r
> source("comparison.R")
Unit: milliseconds
      expr      min       lq     mean   median       uq      max neval cld
     scanf 218.8936 224.1223 238.5650 227.1901 229.9116 1343.433   100   c
      atof 124.8087 127.3274 129.4104 128.5858 130.9138  146.334   100  b 
    strtod 124.5705 127.2157 129.1238 129.1042 130.7504  137.143   100  b 
      stod 127.1751 129.7343 131.7339 131.4854 133.1425  147.763   100  b 
 fastfloat  40.6219  41.3042  42.5729  42.3209  43.1738   57.788   100 a  
> 
```

Or in chart form:

![](https://eddelbuettel.github.io/rcppfastfloat/comparison.png)


### Status

Right now the package is brand new and reasonably empty. 

### Contributing

Any problems, bug reports, or features requests for the package can be submitted and handled most
conveniently as [Github issues](https://github.com/eddelbuettel/rcppfastfloat/issues) in the
repository.

Before submitting pull requests, it is frequently preferable to first discuss need and scope in such
an issue ticket.  See the file
[Contributing.md](https://github.com/RcppCore/Rcpp/blob/master/Contributing.md) (in the
[Rcpp](https://github.com/RcppCore/Rcpp) repo) for a brief discussion.

### Author

For the R package, [Dirk Eddelbuettel](https://github.com/eddelbuettel).

For everything pertaining to `fast_float`, [Daniel Lemire](https://lemire.me/en/) (and
[contributors](https://github.com/fastfloat/fast_float/graphs/contributors)).
