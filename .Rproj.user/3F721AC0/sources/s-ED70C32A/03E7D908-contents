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
  def <- try_read_csv("http://landregistry.data.gov.uk/def/common.csv?_pageSize=100")
  if (!tibble::is_tibble(def)) {
    message(def)
    return(invisible(NULL))
  }
  def$uri <- gsub(".*ukhpi/(.+)", "\\1", def$uri)
  def
}

#' @rdname uklr_def
#' @export
ukhp_def <- function() {
  def <- try_read_csv("http://landregistry.data.gov.uk/def/ukhpi.csv?_pageSize=100")
  if (!tibble::is_tibble(def)) {
    message(def)
    return(invisible(NULL))
  }
  def$uri <- gsub(".*ukhpi/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}

#' @rdname uklr_def
#' @export
ukppd_def <- function() {
  def <- try_read_csv("http://landregistry.data.gov.uk/def/ppi.csv?_pageSize=100")
  if (!tibble::is_tibble(def)) {
    message(def)
    return(invisible(NULL))
  }
  def$uri <- gsub(".*ppi/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}


#' @rdname uklr_def
#' @importFrom tibble is_tibble
#' @export
uktrans_def <- function() {
  def <- try_read_csv("http://landregistry.data.gov.uk/def/trans.csv?_pageSize=100")
  if (!tibble::is_tibble(def)) {
    message(def)
    return(invisible(NULL))
  }
  def$uri <- gsub(".*trans/(.+)", "\\1", def$uri)
  nms <- names(def)
  nms_ <- gsub("\\.\\.\\.", "_", nms)
  names(def) <- gsub("\\.", "", nms_)
  as_tibble(def)
}

try_read_csv <- function(x, ...) {
  tryCatch(
    as_tibble(read.csv(x, ...)),
    error = function(e) conditionMessage(e),
    warning = function(w) conditionMessage(w)
  )
}
