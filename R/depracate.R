#' @title Deprecated functions in package \pkg{uklr}.
#'
#' @description The functions listed below are deprecated and will be defunct in
#'   the near future. When possible, alternative functions with similar
#'   functionality are also mentioned. Help pages for deprecated functions are
#'   available at \code{help("-deprecated")}.
#' @name uklr-deprecated
#' @keywords internal
#' @export
get_query <- function(x) {
  .Deprecated("get_query()", package = "exuber")
  retrieve_query(x)
}
