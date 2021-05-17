#' Display Land Registry available categories
#'
#' \code{ukhp_avail_regions()} displays available regions, \code{ukhp_avail_regions()}
#' displays available items, \code{ukhp_avail_date_span()} displays available date sample,
#' and \code{ukhp_avail_date_last} displays the last available date.
#'
#' @return Returns a character vector.
#'
#' @export
#' @examples
#'
#' ukhp_avail_regions()[1:10]
#' ukhp_avail_items()
#' ukhp_avail_date_last()
#'
ukhp_avail_items <- function() {
  .query <- build_sparql_file_query(
    "ukhpi", "region", "newport", "month","2013-10")
  proc <- process_request(.query)
  proc %||% return(invisible(NULL))
  categories_url <- grep("ukhpi", proc$type, value = TRUE)
  complete <- gsub(".*ukhpi/(.+)", "\\1", categories_url)
  grep("^[^ref]", complete, value = TRUE)
}

#' @rdname ukhp_avail_items
#' @export
ukhp_avail_regions <- function() {
  .query <- ukhp_build_sparql(
    .start_date = "2008-12-31",
    .end_date = "2009-01-01"
  )
  proc <- process_request(.query)
  proc %||% return(invisible(NULL))
  out <- gsub(".*region/(.+)/month/.*", "\\1", proc$region) # there are duplicates
  unique(out)
}

ukhp_avail_items_ref <- function() {
  .query <- build_sparql_file_query(
    "ukhpi", "region", "newport", "month","2013-10")
  proc <- process_request(.query)
  categories_url <- grep("ukhpi", proc$type, value = TRUE)
  complete <- gsub(".*ukhpi/(.+)", "\\1", categories_url)
  grep("ref", complete, value = TRUE)
}

#' @rdname ukhp_avail_items
#' @export
ukhp_avail_date_span <- function() {
  .query <- ukhp_build_sparql(
    .region = "east-midlands")
  proc <- process_request(.query)
  as.Date(proc$date)
}

#' @rdname ukhp_avail_items
#' @export
ukhp_avail_date_last <- function() {
  .query <- ukhp_build_sparql(
    .start_date = "2019-01-01",
    .region = "east-midlands"
  )
  proc <- process_request(.query)
  date <- as.Date(proc$date)
  date[length(date)]
}



