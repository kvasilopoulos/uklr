#' Definitions
#'
#' @importFrom utils read.csv
#' @export
#'
uklr_def <- function() {
read.csv("http://landregistry.data.gov.uk/def/common.csv?_page=1")
def <- read.csv("http://landregistry.data.gov.uk/def/commmon.csv?_pageSize=100")
def$uri <- gsub(".*ukhpi/(.+)", "\\1", def$uri)
}

#' @rdname uklr_def
ukhp_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/ukhpi.csv?_pageSize=100")
  def$uri <- gsub(".*ukhpi/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}

#' @rdname uklr_def
ukppd_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/ppi.csv?_pageSize=100")
  def$uri <- gsub(".*ppi/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}


#' @rdname uklr_def
uktrans_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/trans.csv?_pageSize=100")
  def$uri <- gsub(".*trans/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}
