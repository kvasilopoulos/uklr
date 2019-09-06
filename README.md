
<!-- README.md is generated from README.Rmd. Please edit that file -->

# uklr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of uklr is to …

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kvasilopoulos/uklr")
```

## Example

``` r
library(uklr)
#> Loading required package: SPARQL
#> Loading required package: XML
#> Loading required package: RCurl
#> Loading required package: bitops

ukhp_get(region = "newport", start_date = "2019-01-01")
#>    region       date housePriceIndex
#> 1 newport 2019-01-01          128.17
#> 2 newport 2019-02-01          129.83
#> 3 newport 2019-03-01          131.86
#> 4 newport 2019-04-01          132.68
#> 5 newport 2019-05-01          133.14
#> 6 newport 2019-06-01          130.99

ukppd_get(postcode = "PL6 8RU", start_date = "2015-01-01")
#>   postcode amount       date                             category
#> 1  PL6 8RU 202500 2015-06-29 "Standard price paid transaction"@en
#> 2  PL6 8RU 195000 2016-07-08 "Standard price paid transaction"@en
#> 3  PL6 8RU 245000 2016-08-19 "Standard price paid transaction"@en
#> 4  PL6 8RU 255000 2016-09-07 "Standard price paid transaction"@en
#> 5  PL6 8RU 280000 2017-10-02 "Standard price paid transaction"@en
#> 6  PL6 8RU 207000 2018-03-29 "Standard price paid transaction"@en
#> 7  PL6 8RU 205000 2018-09-07 "Standard price paid transaction"@en
```
