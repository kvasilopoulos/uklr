#' Display Price Paid Date available categories
#'
#' \code{ukppd_avail_items()} displays all availale items for search,
#' \code{ukppd_avail_optional_items()} displays optional items that refer to the
#' location of the transcaction and \code{ukppd_avail_postcodes} displays the
#' available postcodes.
#'/
#' @export
#'
#' @examples
#'
#' ukppd_avail_items()
#'
#' ukppd_avail_optional_items()
#'
#' ukppd_avail_postcodes()[1:10]
#'
ukppd_avail_items <- function() {
  query <- build_sparql_file_query(
    "ppi", "transaction", "0A73B494-6838-4604-961B-0453DF4CC0BB", "current")
  proc <- process_request(query)
  gsub(".*/ppi/(.+)", "\\1", proc$type[-1])
}

#'@rdname ukppd_avail_items
ukppd_avail_optional_items <- function() {
  query <- build_sparql_file_query(
    "ppi", "address", "e738e64c33d83e5492f9a1bb0e3e4c24ed4ce684")
  proc <- process_request(query)
  gsub(".*/common/(.+)", "\\1", proc$type[-1])
}

#' @rdname ukppd_avail_items
ukppd_avail_postcodes <- function() {
 ons_pc()
}
