#' Get House Price Data
#'
#' @export
#' @param region the region to select. If regexp is set to FALSE then the matching
#' should be exact, see \code{ukhp_avail_regions} for available regions. If regexp
#' is set to TRUE then partial matching is possible. Furthermore it is set to
#' NULL selects all available regions.
#' @param item the item to select. See \code{ukhp_avail_items} for the available categories.
#' @param regexp use regular expression in sparql to search for regions.
#' @param start_date the start date
#' @param end_date the end date
#' @param ... query modifiers passed through \code{rdf_modifiers}.
#'
#' @seealso \code{rdf_modifiers}
#'
#' @examples
#'\donttest{
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
#'}
ukhp_get <- function(region = "england", item = "housePriceIndex", regexp = TRUE,
                     start_date = NULL, end_date = NULL, ...) {
  assert_valid_ukhp_region(region)
  assert_valid_ukhp_items(item)
  query <- ukhp_build_sparql(
    .item = item, .region = region,
    .start_date = start_date, .end_date = end_date, ...)
  res <- process_request(query)
  res$region <- as.factor(gsub(".*region/(.+)/month/.*", "\\1", res$region))
  res$date <- as.Date(res$date)
  item_names <- names(res)[-c(1,2)]
  res[,item_names] <- lapply(res[,item_names], as.numeric)
  if (isFALSE(regexp) & !is.null(region)) {
    region_filter <- region
    res <- subset(res, region %in% region_filter)
  }
  res
}

# assertions ukhp -----------------------------------------------------------

assert_valid_ukhp_items <- function(x) {
  x %||% invisible()
  if (any(x %ni% ukhp_avail_items()))
    stop("invalid item, see `ukhp_avail_items()`", call. = FALSE)
}

assert_valid_ukhp_region <- function(x) {
  x %||% invisible()
  if (any(x %ni% ukhp_avail_regions()))
    stop("invalid region, see `ukhp_avail_regions()`", call. = FALSE)
}



# Price paid Data ---------------------------------------------------------


#' Get Price Paid Data
#'
#' @param postcode postcode to select
#' @param item item to select
#' @param optional_item optional item to select
#' @inheritParams ukhp_get
#'
#' @export
#' @examples
#' \donttest{
#' ukppd_get("PL6 8RU")
#' ukppd_get("PL6 8RU", start_date = "2001-01-01")
#' ukppd_get("PL6 8RU", start_date = "2001-01-01")
#' }
ukppd_get <- function(postcode = "PL6 8RU", item = NULL, optional_item = NULL,
                      start_date = NULL, end_date = NULL, ...) {
  assert_valid_ukppd_postcodes(postcode)
  assert_valid_ukppd_items(item)
  assert_valid_ukppd_optional_items(optional_item)
  query <- ukppd_build_sparql(
    .postcode = postcode, .item = item, .optional_item = optional_item,
    .start_date = start_date, .end_date = end_date, ...)
  res <- process_request(query)
  res$amount <- as.numeric(res$amount)
  res$date <- as.Date(res$date)
  res$category <- gsub("@en", "", res$category)
  res
}

# assertions ukppd ---------------------------------------------------------

assert_valid_ukppd_items <- function(x) {
  x %||% invisible()
  if (any(x %ni% ukppd_avail_items()))
    stop("invalid item, see `ukppd_avail_items()`", call. = FALSE)
}

assert_valid_ukppd_optional_items <- function(x) {
  x %||% invisible()
  if (any(x %ni% ukppd_avail_optional_items()))
    stop("invalid optional item, see `ukppd_avail_optional_items()`",
         call. = FALSE)
}

assert_valid_ukppd_postcodes <- function(x) {
  x %||% invisible()
  if (any(x %ni% ukppd_avail_postcodes()))
    stop("invalid postcode, see `ukppd_avail_postcodes()`", call. = FALSE)
}


# Transaction data --------------------------------------------------------

#' Get Transaction Data
#'
#' @param item item to select
#' @inheritParams ukhp_get
#'
#' @export
#' @examples
#'\donttest{
#' uktrans_get(item = "totalApplicationCountByRegion", region = "East Anglia")
#'
#' # If `region` is left as NULL then it returns all available regions
#' uktrans_get(item = "totalApplicationCountByRegion")
#'
#' # Quering all available transaction data
#' uktrans_get(item = uktrans_avail_items())
#' }
uktrans_get <- function(item = "totalApplicationCountByRegion", region = NULL,
                        regexp = TRUE, start_date = NULL, end_date = NULL, ...) {
  assert_valid_uktrans_items(item)
  assert_valid_uktrans_regions(region)
  query <- uktrans_build_sparql(
    .item = item, .region = region,  .start_date = start_date,
    .end_date = end_date)
  res <- process_request(query)
  res$date <- as.Date(res$date)
  if (isFALSE(regexp) & !is.null(region)) {
    region_filter <- region
    res <- subset(res, region %in% region_filter)
  }
  res
}

# assertions uktrans ------------------------------------------------------

assert_valid_uktrans_items <- function(x) {
  x %||% invisible()
  if (any(x %ni% uktrans_avail_items()))
    stop("invalid item, see `uktrans_avail_items()`", call. = FALSE)
}

assert_valid_uktrans_regions <- function(x) {
  x %||% invisible()
  if (any(x %ni% uktrans_avail_regions()))
    stop("invalid region, see `uktrans_avail_regions()`", call. = FALSE)
}
