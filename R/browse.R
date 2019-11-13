#' Quickly browse to Land Registry's webpage
#'
#' These functions take you to land registry's webpages and return the URL invisibly.
#'
#' @export
#' @examples
#' uklr_browse()
#' ukhp_browse()
#' ukppd_browse()
uklr_browse <- function() {
  view_url("http://landregistry.data.gov.uk/")
}

#' @rdname uklr_browse
ukhp_browse <- function() {
  view_url("http://landregistry.data.gov.uk/def/ukhpi")
}

#' @rdname uklr_browse
ukppd_browse <- function() {
  view_url("http://landregistry.data.gov.uk/def/ppi")
}

#' @rdname uklr_browse
uktrans_browse <- function() {
  view_url("http://landregistry.data.gov.uk/def/trans")
}
