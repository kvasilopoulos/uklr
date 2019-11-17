
#' Office of National Statistic Location Classification
#'
#' \code{ons_lookup} provides a table that that combines Local Authority
#' District 1 and 2 to NUTS3, NUTS2 and NUTS1. Fucntion \code{ons_countries},
#' \code{ons_regions}, \code{ons_eng_counties} and \code{ons_la}
#' provide a vector of countries, regions, English counties and local authorities
#' respectively.
#'
#' @param modify Modifies the vector to conformity with the package.
#' @export
#' @examples
#'
#' ons_lookup()
#'
#'
ons_lookup <- function() {
  x <- httr::GET("http://geoportal1-ons.opendata.arcgis.com/datasets/9b4c94e915c844adb11e15a4b1e1294d_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  as_tibble(y$properties)
}


gsub_lr <- function(x, lgl) {
  if (lgl) x <- tolower(gsub("(?:,|\\s)\\s*", "-", x))
  x
}

#' @rdname ons_lookup
ons_countries <- function(modify = TRUE) {
  x <- httr::GET("https://opendata.arcgis.com/datasets/7579a399b413418db5a3bdd1c824bffb_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  reg <- y$properties$CTRY18NM
  out <- reg[!reg %in% c("United Kingdom", "Great Britain", "England and Wales")]
  gsub_lr(out, modify)
}

#' @rdname ons_lookup
ons_regions <- function(modify = TRUE) {
  x <- httr::GET("https://opendata.arcgis.com/datasets/7d1316afac3f4d508cd07592715cb0ee_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  gsub_lr(y$properties$RGN18NM, modify)
}

#' @rdname ons_lookup
ons_eng_counties <- function(modify = TRUE) {
  x <- httr::GET("https://opendata.arcgis.com/datasets/1e96fd2cc44e4dbc8c6f96f7340562fe_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  gsub_lr(y$properties$CTY18NM, modify)
}

#' @rdname ons_lookup
ons_la <- function(modify = FALSE) {
  x <- httr::GET("https://opendata.arcgis.com/datasets/17eb563791b648f9a7025ca408bb09c6_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  out <- y$properties$LAD18NM
  if (modify) {
    out <- gsub_lr(out, TRUE)
    all <- ukhp_avail_regions()
    out[!ukhp_avail_regions() %in% all] <- c(
      "north-down-and-ards",
      "city-of-kingston-upon-hull",
      "city-of-aberdeen",
      "city-of-derby",
      "city-of-nottingham",
      "herefordshire",
      "city-of-dundee",
      "city-of-glasgow",
      "city-of-bristol",
      "city-of-plymouth",
      "city-of-peterborough",
      "st-helens",
      "",
      "shepway",
      "city-of-westminster",
      "armagh-banbridge-and-craigavon",
      "derry-and-strabane"
    )
    out <- out[out != ""]
  }
  out
}

ons_pc <- function(pmatch = NULL) {
  if (!is.null(pmatch)) {
    out <- grep(pmatch, pc$CODE, value = TRUE)
  } else {
    out <- pc$CODE
  }
  out
}

ons_nuts1 <- function() {
  unique(ons_lookup()$NUTS118NM)
}


ons_nuts2 <- function() {
  unique(ons_lookup()$NUTS218NM)
}

ons_nuts3 <- function() {
  unique(ons_lookup()$NUTS318NM)
}

ons_lad <- function() {
  unique(ons_lookup()$LAU118NM)
}

#' UK Postcodes
#'
#'
#'
"pc"
