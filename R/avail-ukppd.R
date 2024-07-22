#' Display Price Paid Date available categories
#'
#' \code{ukppd_avail_items()} displays all available items for search,
#' \code{ukppd_avail_optional_items()} displays optional items that refer to the
#' location of the transaction and \code{ukppd_avail_postcodes} displays the
#' available postcodes.
#'/
#' @export
#'
#' @return Returns a character vector.
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
  proc %||% return(invisible(NULL))
  all_items <- gsub(".*/ppi/(.+)", "\\1", proc$type[-1])
  already_included <- c("transactionDate", "pricePaid", "transactionCategory")
  setdiff(all_items, already_included)
  # lrppi_label <- c("recordStatus", "propertyType", "estateType", "transactionCategory")
  # if (label) {
  #   skos_label <- out %in% lrppi_label
  #   out[skos_label] <- paste0(out[skos_label], "/skos:prefLabel")
  # }
  # out
}

#'@rdname ukppd_avail_items
#'@export
ukppd_avail_optional_items <- function() {
  query <- build_sparql_file_query(
    "ppi", "address", "e738e64c33d83e5492f9a1bb0e3e4c24ed4ce684")
  proc <- process_request(query)
  proc %||% return(invisible(NULL))
  all_items <- gsub(".*/common/(.+)", "\\1", proc$type[-1])
  already_included <- c("postcode")
  setdiff(all_items, already_included)
}

#' @rdname ukppd_avail_items
#' @export
ukppd_avail_postcodes <- function() {
  pc_ <- get("internal_postcodes_2018")
  pc_$NUTS3 <- gsub("[0-9]", "", pc_$NUTS3)
  # pc_[!pc_$NUTS3 %in% c("UKM", "UKN"), ]$CODE  # what is this? don't want to return those 2 codes?
  o = pc_[!pc_$NUTS3 %in% c("UKM", "UKN"), ]
  o$PC  # return simple vector
}
