
uktrans_avail_items <- function() {
  .query <- build_sparql_file_query(
    "trans", "applications-by-region", "2011-12-00009")
  proc <- process_request(.query)
  categories_url <- grep("trans", proc$type, value = TRUE)
  complete <- gsub(".*trans/(.+)", "\\1", categories_url)
  complete[-c(5, 14)]
}

uktrans_avail_regions <- function() {
  .query <- "SELECT DISTINCT ?region{ ?type trans:regionName ?region}"
  proc <- process_request(.query)
  proc$region
}
