#' Linked Data Definitions
#'
#' These functions return the definitions for the linked data construction in
#' a tibble.
#'
#' @importFrom utils read.csv
#'
#' @return Returns a tibble.
#' @export
#'
#' @examples
#' \donttest{
#' uklr_def()
#'
#' ukhp_def()
#' }
uklr_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/common.csv?_pageSize=100")
  def$uri <- gsub(".*ukhpi/(.+)", "\\1", def$uri)
  as_tibble(def)
}

#' @rdname uklr_def
#' @export
ukhp_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/ukhpi.csv?_pageSize=100")
  def$uri <- gsub(".*ukhpi/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}

#' @rdname uklr_def
#' @export
ukppd_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/ppi.csv?_pageSize=100")
  def$uri <- gsub(".*ppi/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}


#' @rdname uklr_def
#' @export
uktrans_def <- function() {
  def <- read.csv("http://landregistry.data.gov.uk/def/trans.csv?_pageSize=100")
  def$uri <- gsub(".*trans/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}
