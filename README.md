
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

ukhp_get(region = "newport", start_date = "2019-01-01")
#> # A tibble: 9 x 3
#>   region  date       housePriceIndex
#>   <fct>   <date>               <dbl>
#> 1 newport 2019-01-01            129.
#> 2 newport 2019-02-01            130.
#> 3 newport 2019-03-01            131.
#> 4 newport 2019-04-01            132.
#> 5 newport 2019-05-01            133.
#> 6 newport 2019-06-01            132.
#> 7 newport 2019-07-01            134.
#> 8 newport 2019-08-01            135.
#> 9 newport 2019-09-01            136.

ukppd_get(postcode = "PL6 8RU", start_date = "2015-01-01")
#> # A tibble: 7 x 4
#>   postcode amount date       category                       
#>   <chr>    <chr>  <chr>      <chr>                          
#> 1 PL6 8RU  202500 2015-06-29 Standard price paid transaction
#> 2 PL6 8RU  195000 2016-07-08 Standard price paid transaction
#> 3 PL6 8RU  245000 2016-08-19 Standard price paid transaction
#> 4 PL6 8RU  255000 2016-09-07 Standard price paid transaction
#> 5 PL6 8RU  280000 2017-10-02 Standard price paid transaction
#> 6 PL6 8RU  207000 2018-03-29 Standard price paid transaction
#> 7 PL6 8RU  205000 2018-09-07 Standard price paid transaction
```
