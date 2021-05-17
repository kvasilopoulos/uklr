
process_request <- function(.query, ...) {
  req <- prefix_query(.query)
  res <- sparql(query = req, ...)
  res %||% return(invisible(NULL))
  tbl <- process_json(res)
  msg_empty(tbl)
  class(.query) <- "query"
  structure(tbl, query = .query)
}

msg_empty <- function(x) {
  if (empty(x)) {
    message("empty dataframe, check your query!")
  }
}

#' @importFrom httr timeout RETRY
try_GET <- function(x, ...) {
  tryCatch(
    RETRY("GET", quiet = TRUE, url = x, timeout(10), ...),
    error = function(e) conditionMessage(e),
    warning = function(w) conditionMessage(w)
  )
}
is_response <- function(x) {
  class(x) == "response"
}

#' Tools to create a custom SPARQL query
#'
#' Function to create custom queries with the `/landregistry/query endpoint`. All
#' necessary prefixes have to be included and output will be parsed from json to
#' dataframe. The most prefixes from land registry can be include with \code{prefix_query}.
#'
#' @param query custom query.
#' @param endpoint land registry's web service endpoint.
#' @param ... further arguments passed to \code{httr::GET}.
#'
#' @importFrom httr message_for_status GET
#' @importFrom utils URLencode
#' @importFrom tibble as_tibble
#' @importFrom curl has_internet
#'
#' @return Returns a tibble that has been parsed from json.
#'
#' @export
#' @examples
#' custom_query <- "select * where {
#'   <http://landregistry.data.gov.uk/data/ukhpi/region/newport/month/2013-10> ?property ?value
#' }"
#' sparql(prefix_query(custom_query))
#'
sparql <- function(query, endpoint = "http://landregistry.data.gov.uk/landregistry/query", ...){

  enc_query <- gsub("\\+", "%2B", URLencode(query, reserved = TRUE))
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }
  res <- try_GET(
    paste(endpoint, "?query=", enc_query, sep = ""),
    httr::add_headers("Accept" = "application/sparql-results+json"),
    ...
  )
  if (!is_response(res)) {
    message(res)
    return(invisible(NULL))
  }
  if (httr::http_error(res)) {
    message_for_status(res)
    return(invisible(NULL))
  }
  res
}

process_json <- function(res) {
  res <- jsonlite::parse_json(res, simplifyVector = TRUE)$results$bindings
  as_tibble(sapply(res, function(x) x$value))
}

#' Get the sparql query performed with \code{sparql}.
#'
#' @param x the result of query.
#'
#' @return Returns the a character vector with the query.
#'
retrieve_query <- function(x) {
  attr(x, "query")
}


print.query <- function(x) {
  cat(x)
}

#' @rdname sparql
#' @export
prefix_query <- function(query) {
  prefix <- paste(
    'prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>',
    'prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>',
    'prefix owl: <http://www.w3.org/2002/07/owl#>',
    'prefix xsd: <http://www.w3.org/2001/XMLSchema#>',
    'prefix skos: <http://www.w3.org/2004/02/skos/core#>',
    'prefix sr: <http://data.ordnancesurvey.co.uk/ontology/spatialrelations/>',
    'prefix ukhpi: <http://landregistry.data.gov.uk/def/ukhpi/>',
    'prefix lrppi: <http://landregistry.data.gov.uk/def/ppi/>',
    'prefix lrcommon: <http://landregistry.data.gov.uk/def/common/>',
    'prefix trans: <http://landregistry.data.gov.uk/def/trans/>',
    sep = "\n")
  paste(prefix, query, sep = "\n")
}
