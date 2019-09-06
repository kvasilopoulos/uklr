#' Display Land Registry available categories and regions
#'
#' @export
#'
ukhp_avail_categories <- function() {
  .query <- build_sparql_file_query(
    "ukhpi", "region", "newport", "month","2013-10")
  proc <- process_request(.query)
  categories_url <- grep("ukhpi", proc$results$type, value = TRUE)
  complete <- gsub(".*ukhpi/(.+)>", "\\1", categories_url)
  grep("^[^ref]", complete, value = TRUE)
}

#' @rdname ukhp_avail_categories
ukhp_avail_regions <- function() {
  .query <- ukhp_build_sparql_query(
    .start_date = "2008-12-31",
    .end_date = "2009-02-01"
  )
  proc <- process_request(.query)
  gsub(".*region:(.+)/month/.*", "\\1", proc$results$region)
}


ukhp_avail_categories_ref <- function() {
  .query <- build_sparql_file_query(
    "ukhpi", "region", "newport", "month","2013-10")
  proc <- process_request(.query)
  categories_url <- grep("ukhpi", proc$results$property, value = TRUE)
  complete <- gsub(".*ukhpi/(.+)>", "\\1", categories_url)
  grep("ref", complete, value = TRUE)
}

ukhp_avail_date_last <- function() {
  .query <- ukhp_build_sparql_query(
    .start_date = "2019-01-01",
    .region = "east-midlands"
  )
  proc <- process_request(.query)
  date <- as.Date(proc$results$date)
  date[length(date)]
}


ukhp_avail_date_span <- function() {
  .query <- ukhp_build_sparql_query(
    .region = "east-midlands")
  proc <- process_request(.query)
  as.Date(proc$results$date)
}
