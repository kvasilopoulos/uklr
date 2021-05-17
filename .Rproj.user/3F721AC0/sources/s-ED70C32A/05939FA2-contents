# camel_to_snake <- function(x) {
#   x1 <- gsub("([A-Z])","\\_\\1", x)
#   substr(tolower(x1), 1, .Machine$integer.max)
# }
# snake_to_camel <- function(x, first = FALSE) {
#   x1 <- gsub("(^|[^[:alnum:]])([[:alnum:]])", "\\U\\2", x, perl = TRUE)
#   if (isFALSE(first)) {
#     first_letter <- tolower(substring(x1, 1,1))
#     body <- substring(x1, 2)
#     paste0(first_letter, body)
#   }
# }

`%||%`  <- function(x, y) {
  if (is.null(x)) {
    y
  } else{
    x
  }
}

`%!||%` <- function(x, y) {
  if (!is.null(x)) {
    y
  } else{
    x
  }
}

`%ni%` <- Negate(`%in%`)

view_url <- function(url, open = interactive()) {
  if (open) {
    utils::browseURL(url)
  }
  invisible(url)
}

empty <- function(df) {
  (is.null(df) || nrow(df) == 0 || ncol(df) == 0)
}




# if (getRversion() >= "2.15.1") {
#   utils::globalVariables(
#     c("pc")
#   )
# }
