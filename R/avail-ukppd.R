#' Display Price Paid Date available categories
#'
#' @export
ukppd_avail_categories <- function() {
  query <- build_sparql_file_query(
    "ppi", "transaction", "0A73B494-6838-4604-961B-0453DF4CC0BB", "current")
  proc <- process_request(query)
  gsub(".*/ppi/(.+)>", "\\1", proc[-1,1])
}

#'@rdname ukppd_avail_categories
ukppd_avail_optional_categories <- function() {
  query <- build_sparql_file_query(
    "ppi", "address", "e738e64c33d83e5492f9a1bb0e3e4c24ed4ce684")
  proc <- process_request(query)
  gsub(".*/common/(.+)>", "\\1", proc$results[-1,1])
}

# ukppd_avail_postcodes <- function() {
#   query <- sparql_select_where(
#     type = "Distinct",
#     "?s lrcommon:postcode ?postcode",
#     append = sparql_limit(100))
#
#   proc <- process_request(query)
#   unlist(proc, use.names = F)
# }
