#' Get House Price Data
#'
#' The UK House Price Index (UK HPI) captures changes in the value of residential
#' properties. The UK HPI uses sales data collected on residential housing
#' transactions, whether for cash or with a mortgage. Data is available at a
#' national and regional level, as well as counties, local authorities and London boroughs.
#'
#' @details
#'
#' Properties have been included:
#'
#' \itemize{
#'  \item in England and Wales since January 1995
#'  \item in Scotland since January 2004
#'  \item in Northern Ireland since January 2005
#' }
#'
#' @export
#' @param region the region to select. If regexp is set to FALSE then the matching
#' should be exact, see \code{ukhp_avail_regions} for available regions. If regexp
#' is set to TRUE then partial matching is possible. Furthermore if it is set to
#' NULL then selects all available regions.
#' @param item the item to select. See \code{ukhp_avail_items} for the available
#' categories.
#' @param regexp use regular expression in sparql to search for regions.
#' @param start_date the start date as YYYY-MM-DD.
#' @param end_date the end date as YYYY-MM-DD.
#' @param ... query modifiers passed through \code{rdf_modifiers}.
#'
#' @seealso \code{rdf_modifiers}
#'
#' @return Returns a tibble in long format.
#'
#' @examples
#'\donttest{
#' # This is case sensitive
#' ukhp_get("england")
#'
#' # However you can use regular expression instead of exact match
#' ukhp_get("england", regexp = TRUE)
#'
#' # For all available items
#' ukhp_avail_items()
#'
#' ukhp_get(c("england", "wales"), item = c("salesVolume", "housePriceIndexDetached"))
#'}
ukhp_get <- function(region = "england", item = "housePriceIndex", regexp = FALSE,
                     start_date = NULL, end_date = NULL, ...) {
  suppressMessages({
    assert_valid_ukhp_region(region)
    assert_valid_ukhp_items(item)
  })
  query <- ukhp_build_sparql(
    .item = item, .region = region,
    .start_date = start_date, .end_date = end_date, ...)
  res <- process_request(query)
  res %||% return(invisible(NULL))
  if(empty(res)) return(invisible(res))
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
  x %||% return(invisible(NULL))
  avail <- ukhp_avail_items()
  avail %||% return(invisible(NULL))
  if (any(x %ni% avail))
    stop("invalid item, see `ukhp_avail_items()`", call. = FALSE)
}

assert_valid_ukhp_region <- function(x) {
  x %||% return(invisible(NULL))
  avail <- ukhp_avail_regions()
  avail %||% return(invisible(NULL))
  if (any(x %ni% avail))
    stop("invalid region, see `ukhp_avail_regions()`", call. = FALSE)
}



# Price paid Data ---------------------------------------------------------


#' Get Price Paid Data
#'
#' Price Paid Data tracks property sales in England and Wales submitted to HM Land
#' Registry for registration.  Price Paid Data is based on the raw data released each month.
#'
#' @param postcode postcode to select, see \code{ukppd_avail_postcode()} for
#' available postcodes.
#' @param item item to select, see \code{ukppd_avail_items()} for
#' available items.
#' @param optional_item optional item to select that describes the location of
#' the transaction, , see \code{ukppd_avail_optional_items()} for available
#' items.
#' @inheritParams ukhp_get
#'
#' @return Returns a tibble in long format.
#'
#' @export
#' @examples
#' \donttest{
#' ukppd_get("PL6 8RU")
#'
#' ukppd_get("PL6 8RU", start_date = "2001-01-01")
#'
#' ukppd_get("PL6 8RU", item = "newBuild", optional_item = "street")
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
  res %||% return(invisible(NULL))
  if(empty(res)) return(invisible(res))
  res <- clear_uri(res)
  res$amount <- as.numeric(res$amount)
  res$date <- as.Date(res$date)
  res$category <- gsub("@en", "", res$category)
  res
}

clear_uri <- function(x) {
  common <- c("propertyType", "estateType")
  ppi_address <- "propertyAddress"
  ppi_transaction <- "hasTransaction"
  ppi <- c('recordStatus', "transactionCategory")
  pat <- ".*[ppi/transaction|ppi/address|ppi|common]/(.+)"
  prefixed <- c(ppi_transaction, ppi_address, ppi, common)
  lgl_idx <- colnames(x) %in% prefixed
  if (any(lgl_idx)) {
    x[, lgl_idx] <- lapply(x[, lgl_idx], function(y) gsub(pat, "\\1", y))
  }
  x
}


# assertions ukppd ---------------------------------------------------------

assert_valid_ukppd_items <- function(x) {
  x %||% return(invisible(NULL))
  avail <- ukppd_avail_items()
  avail %||% return(invisible(NULL))
  if (any(x %ni% avail))
    stop("invalid item, see `ukppd_avail_items()`", call. = FALSE)
}

assert_valid_ukppd_optional_items <- function(x) {
  x %||% return(invisible(NULL))
  avail <- ukppd_avail_optional_items()
  avail %||% return(invisible(NULL))
  if (any(x %ni% avail))
    stop("invalid optional item, see `ukppd_avail_optional_items()`",
         call. = FALSE)
}

assert_valid_ukppd_postcodes <- function(x) {
  x %||% return(invisible(NULL))
  avail <- ukppd_avail_postcodes()
  avail %||% return(invisible(NULL))
  if (any(x %ni% avail))
    stop("invalid postcode, see `ukppd_avail_postcodes()`", call. = FALSE)
}


# Transaction data --------------------------------------------------------

#' Get Transaction Data
#'
#' Transaction Data is a dataset that shows how many customer applications we completed,
#' in the preceding month for: first registrations, leases, transfers of part,
#' dealings, official copies and searches. This is based on customer and location.
#'
#' @param item item to select, see \code{uktrans_avail_items()} for
#' available items.
#' @param region  region to select, see \code{uktrans_avail_regions()} for
#' available regions.
#' @inheritParams ukhp_get
#'
#' @return Returns a tibble in long format.
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
    .item = item, .region = region, .start_date = start_date,
    .end_date = end_date)
  res <- process_request(query)
  res %||% return(invisible(NULL))
  if(empty(res)) return(invisible(res))
  res$date <- as.Date(res$date)
  item_names <- names(res)[-c(1,2)]
  res[,item_names] <- lapply(res[,item_names], as.numeric)
  if (isFALSE(regexp) & !is.null(region)) {
    region_filter <- region
    res <- subset(res, region %in% region_filter)
  }
  res
}

# assertions uktrans ------------------------------------------------------

assert_valid_uktrans_items <- function(x) {
  x %||% return(invisible(NULL))
  avail <- uktrans_avail_items()
  avail %||% return(invisible(NULL))
  if (any(x %ni% avail))
    stop("invalid item, see `uktrans_avail_items()`", call. = FALSE)
}

assert_valid_uktrans_regions <- function(x) {
  x %||% return(invisible(NULL))
  avail <- uktrans_avail_regions()
  avail %||% return(invisible(NULL))
  if (any(x %ni% avail))
    stop("invalid region, see `uktrans_avail_regions()`", call. = FALSE)
}

