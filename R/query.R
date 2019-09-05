
prefix_query <- function(.query) {
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
  paste(prefix, .query, collapse = "\n")
}

#' @importFrom SPARQL SPARQL
#' @importFrom RCurl getURL
#' @importFrom XML xmlParse getNodeSet xpathApply xmlGetAttr xmlDoc xpathSApply xmlValue
process_request <- function(.query) {
  req <- prefix_query(.query)
  endpoint <- "http://landregistry.data.gov.uk/landregistry/query"
  ns_prefix <- c('region','http://landregistry.data.gov.uk/data/ukhpi/region/*')
  res <- SPARQL(url = endpoint, query = req, ns = ns_prefix, format = "xml")
  res
}
