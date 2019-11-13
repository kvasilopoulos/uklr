uktrans_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/trans.csv?_page=0&_pageSize=50")
  def$uri <- gsub(".*trans/(.+)", "\\1", def$uri)
  # selected <- def[c("uri", "label", "comment")]
  # subsetted <- subset(selected, uri != "datasetDefinition")
  as_tibble(def)
}

uktrans_avail_categories <- function() {
  .query <- build_sparql_file_query(
    "trans", "applications-by-region", "2011-12-00009")
  proc <- process_request(.query)

  categories_url <- grep("trans", proc$type, value = TRUE)
  complete <- gsub(".*trans/(.+)>", "\\1", categories_url)
  complete
}

uktrans_avail_regions <- function() {
  .query <- "SELECT DISTINCT ?region{ ?type trans:regionName ?region}"
  proc <- process_request(.query)
  Reduce(c, proc$results)
}

# SELECT ?region ?dt ?date ?totalApplicationCountByRegion
# {
#   ?url trans:regionName ?region ;
#   trans:countPeriod   ?date;
#   trans:totalApplicationCountByRegion ?totalApplicationCountByRegion
#
#  bind(xsd:date(concat(str(year(?dt)),"-", str(month(?dt)), "-01")) as ?date)
#
# FILTER (
#   ?date > "2008-12-31"^^xsd:date &&
#     ?date < "2012-03-01"^^xsd:date &&
#     regex(str(?region), 'East Anglia', 'i' )
# )
# }




# quert <- "DESCRIBE
#   <http://landregistry.data.gov.uk/data/trans/applications-by-region/2011-12-00009>"
# process_request(quert, format = "tsv")
