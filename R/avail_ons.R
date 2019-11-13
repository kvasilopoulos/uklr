gsub_lr <- function(lgl, x) {
  if (lgl) {
    x <- tolower(gsub("(?:,|\\s)\\s*", "-", x))
  }
  x
}

ons_countries <- function(parse = FALSE) {
  x <- httr::GET("https://opendata.arcgis.com/datasets/7579a399b413418db5a3bdd1c824bffb_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  reg <- y$properties$CTRY18NM
  out <- reg[!reg %in% c("United Kingdom", "Great Britain", "England and Wales")]
  gsub_lr(parse, out)
}

ons_la <- function(parse = FALSE) {
  x <- httr::GET("https://opendata.arcgis.com/datasets/17eb563791b648f9a7025ca408bb09c6_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  gsub_lr(parse, y$properties$LAD18NM)
}

ons_regions <- function(parse = FALSE) {
  x <- httr::GET("https://opendata.arcgis.com/datasets/7d1316afac3f4d508cd07592715cb0ee_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  gsub_lr(parse, y$properties$RGN18NM)
}

ons_eng_counties <- function(parse = FALSE) {
  x <- httr::GET("https://opendata.arcgis.com/datasets/1e96fd2cc44e4dbc8c6f96f7340562fe_0.geojson")
  y <- jsonlite::parse_json(x, simplifyVector = TRUE)$features
  gsbu_lr(parse, y$properties$CTY18NM)
}
