#' Get House Priced data
#'
#' @export
#' @param region the region to select
#' @param item the item to select
#' @param start_date the start date
#' @param end_date the end date
ukhp_get <- function(region = "newport", item = NULL,
                     start_date = NULL, end_date = NULL) {
  query <- ukhp_build_sparql_query(
    .item = item, .region = region,
    .start_date = start_date, .end_date = end_date)
  proc <- process_request(query)
  results <- proc$results
  results$region <- gsub(".*region:(.+)/month/.*", "\\1", results$region)
  results
}

#' Get Price Paid Date
#'
#' @param postcode postcode to select
#' @param item item to select
#' @param optional_item optional item to select
#' @inheritParams ukhp_get
#'
#' @export
#' @examples
#'
#' ukppd_get("PL6 8RU")
#' ukppd_get("PL6 8RU", start_date = "2001-01-01")
#' ukppd_get("PL6 8RU", start_date = "2001-01-01")
ukppd_get <- function(postcode = "PL6 8RU", item = NULL, optional_item = NULL,
                      start_date = NULL, end_date = NULL) {
  query <- ukppd_build_sparql_query(
    .postcode = postcode, .item = item, .optional_item = optional_item,
    .start_date = start_date, .end_date = end_date)
  proc <- process_request(query)
  proc$results
}
