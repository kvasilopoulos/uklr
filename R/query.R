# endpoint <- "http://landregistry.data.gov.uk/landregistry/query"

#' @importFrom httr stop_for_status
#' @importFrom utils URLencode
#' @importFrom tibble as_tibble
sparql <- function(query){
  endpoint <- "http://landregistry.data.gov.uk/landregistry/query"
  enc_query <- gsub("\\+", "%2B", URLencode(query, reserved = TRUE))
  res_json <- httr::GET(
    paste(endpoint, "?query=", enc_query, sep = ""),
    httr::add_headers("Accept" = "application/sparql-results+json")
  )
  httr::stop_for_status(res_json)
  res <- jsonlite::parse_json(res_json, simplifyVector = TRUE)$results$bindings
  as_tibble(sapply(res, function(x) x$value))
}


process_request <- function(.query, ...) {
  req <- prefix_query(.query)
  endpoint <- "http://landregistry.data.gov.uk/landregistry/query"
  res <- sparql(query = req)
  res
}

#' Tools to create a custom SPARQL query
#'
#' Function to create custom queries with the `/landregistry/query endpoint`. All
#' necessary prefixes have to be included and output will be parsed from json to
#' dataframe. The most common prefixes can be include with \code{prefix_query}
#'
#' @param query custom query
#' @export
#' @examples
#' custom_query <- "select * where {
#'   <http://landregistry.data.gov.uk/data/ukhpi/region/newport/month/2013-10> ?property ?value
#' }"
#' build_sparql(prefix_query(custom_query))
build_sparql <- sparql

#' @rdname build_sparql
prefix_query <- function(query) {
  prefix <-
    'prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    prefix owl: <http://www.w3.org/2002/07/owl#>
    prefix xsd: <http://www.w3.org/2001/XMLSchema#>
    prefix skos: <http://www.w3.org/2004/02/skos/core#>
    prefix sr: <http://data.ordnancesurvey.co.uk/ontology/spatialrelations/>
    prefix ukhpi: <http://landregistry.data.gov.uk/def/ukhpi/>
    prefix lrppi: <http://landregistry.data.gov.uk/def/ppi/>
    prefix lrcommon: <http://landregistry.data.gov.uk/def/common/>
    prefix trans: <http://landregistry.data.gov.uk/def/trans/>'
  paste(prefix, query, collapse = "\n")
}
