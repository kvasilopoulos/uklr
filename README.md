
<!-- README.md is generated from README.Rmd. Please edit that file -->

# uklr <img src='man/figures/logo.png' align="right" height="138.5" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/uklr)](https://CRAN.R-project.org/package=uklr)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/kvasilopoulos/uklr/workflows/R-CMD-check/badge.svg)](https://github.com/kvasilopoulos/uklr/actions)
[![Codecov test
coverage](https://codecov.io/gh/kvasilopoulos/uklr/branch/master/graph/badge.svg)](https://codecov.io/gh/kvasilopoulos/uklr)

<!-- badges: end -->

The goal of {uklr} is to access data from HM Land Registry Open Data
<http://landregistry.data.gov.uk/> through SPARQL queries. {uklr}
supports the UK HPI, Transaction Data and Price Paid Data.

## Installation

Install release version from CRAN

``` r
install.packages("uklr")
```

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kvasilopoulos/uklr")
```

If you encounter a clear bug, please file a reproducible example on
[GitHub](https://github.com/kvasilopoulos/uklr/issues).

## Example

``` r
library(uklr)

ukhp_get(region = "newport", start_date = "2019-01-01")
#> # A tibble: 27 x 3
#>    region  date       housePriceIndex
#>    <fct>   <date>               <dbl>
#>  1 newport 2019-01-01            129.
#>  2 newport 2019-02-01            130.
#>  3 newport 2019-03-01            131.
#>  4 newport 2019-04-01            132.
#>  5 newport 2019-05-01            132.
#>  6 newport 2019-06-01            132.
#>  7 newport 2019-07-01            134.
#>  8 newport 2019-08-01            134.
#>  9 newport 2019-09-01            134.
#> 10 newport 2019-10-01            133.
#> # ... with 17 more rows

ukppd_get(postcode = "PL6 8RU", start_date = "2015-01-01")
#> # A tibble: 7 x 4
#>   postcode amount date       category                       
#>   <chr>     <dbl> <date>     <chr>                          
#> 1 PL6 8RU  202500 2015-06-29 Standard price paid transaction
#> 2 PL6 8RU  195000 2016-07-08 Standard price paid transaction
#> 3 PL6 8RU  207000 2018-03-29 Standard price paid transaction
#> 4 PL6 8RU  245000 2016-08-19 Standard price paid transaction
#> 5 PL6 8RU  255000 2016-09-07 Standard price paid transaction
#> 6 PL6 8RU  280000 2017-10-02 Standard price paid transaction
#> 7 PL6 8RU  205000 2018-09-07 Standard price paid transaction

uktrans_get(item = "totalApplicationCountByRegion", region = "East Anglia")
#> # A tibble: 112 x 3
#>    region      date       totalApplicationCountByRegion
#>    <chr>       <date>                             <dbl>
#>  1 East Anglia 2011-12-01                         37819
#>  2 East Anglia 2012-01-01                         44231
#>  3 East Anglia 2012-02-01                         44453
#>  4 East Anglia 2012-03-01                         46814
#>  5 East Anglia 2012-04-01                         40693
#>  6 East Anglia 2012-05-01                         47885
#>  7 East Anglia 2012-06-01                         39506
#>  8 East Anglia 2012-07-01                         46539
#>  9 East Anglia 2012-08-01                         45942
#> 10 East Anglia 2012-09-01                         41976
#> # ... with 102 more rows
```
