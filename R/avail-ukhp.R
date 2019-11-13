
#' Display House Price definitions
#'
#' @importFrom utils read.csv
#' @export
ukhp_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/ukhpi.csv?_pageSize=100")
  def$uri <- gsub(".*ukhpi/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  # selected <- def[c("uri", "label", "comment")]
  # subsetted <- subset(selected, uri != "datasetDefinition")
  as_tibble(def)
}

#' Display Land Registry available regions, items and date-spanning.
#'
#' @export
ukhp_avail_regions <- function() {
  .query <- ukhp_build_sparql_query(
    .start_date = "2008-12-31",
    .end_date = "2009-01-01"
  )
  proc <- process_request(.query)
  gsub(".*region/(.+)/month/.*", "\\1", proc$region)
}

#' @rdname ukhp_avail_regions
#' @export
ukhp_avail_items <- function() {
  .query <- build_sparql_file_query(
    "ukhpi", "region", "newport", "month","2013-10")
  proc <- process_request(.query)
  categories_url <- grep("ukhpi", proc$type, value = TRUE)
  complete <- gsub(".*ukhpi/(.+)", "\\1", categories_url)
  grep("ref", complete, value = TRUE)
  grep("^[^ref]", complete, value = TRUE)
}

#' @rdname ukhp_avail_regions
#' @export
ukhp_avail_items_ref <- function() {
  .query <- build_sparql_file_query(
    "ukhpi", "region", "newport", "month","2013-10")
  proc <- process_request(.query)
  categories_url <- grep("ukhpi", proc$type, value = TRUE)
  complete <- gsub(".*ukhpi/(.+)", "\\1", categories_url)
  grep("ref", complete, value = TRUE)
}

#' @rdname ukhp_avail_regions
#' @export
ukhp_avail_date_span <- function() {
  .query <- ukhp_build_sparql_query(
    .region = "east-midlands")
  proc <- process_request(.query)
  as.Date(proc$date)
}

#' @rdname ukhp_avail_regions
#' @export
ukhp_avail_date_last <- function() {
  .query <- ukhp_build_sparql_query(
    .start_date = "2019-01-01",
    .region = "east-midlands"
  )
  proc <- process_request(.query)
  date <- as.Date(proc$date)
  date[length(date)]
}



