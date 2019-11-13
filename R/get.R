#' Get House Price Data
#'
#' @export
#' @param region the region to select
#' @param item the item to select
#' @param start_date the start date
#' @param end_date the end date
#' @param regexp use regular expression in sparql to search for regions.
#'
#' @examples
#'
#' # This is case sensitive
#' ukhp_get("england")
#'
#' # However you can use regular expression instead of exact match
#' ukhp_get("england", regexp = TRUE)
#'
#' # For all available regions
#' ukhp_avail_regions()
#'
#' # For all available items
#' ukhp_avail_items()
#'
#' ukhp_get(c("endland", "wales"), item = c("salesVolume", "housePriceIndexDetached"))
#'
ukhp_get <- function(region = "england", item = NULL,
                     start_date = NULL, end_date = NULL, regexp = FALSE) {
  query <- ukhp_build_sparql_query(
    .item = item, .region = region,
    .start_date = start_date, .end_date = end_date)
  res <- process_request(query)
  res$region <- as.factor(gsub(".*region/(.+)/month/.*", "\\1", res$region))
  res$date <- as.Date(res$date)
  item_names <- names(res)[-c(1,2)]
  res[,item_names] <- lapply(res[,item_names], as.numeric)
  if (isFALSE(regexp)) {
    region_filter <- region
    res <- subset(res, region %in% region_filter)
  }
  res
}

#' Get Price Paid Data
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
  res <- process_request(query)
  res$category <- gsub("@en", "", res$category)
  res
}
