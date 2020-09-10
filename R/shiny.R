
# run_shiny <- function() {
#   appDir <- system.file("shiny", package = "uklr")
#   if(appDir == "") {
#     stop("Could not find the `shiny` directory. Try re-installing `uklr`.", call. = FALSE)
#   }
#   if(!requireNamespace("shiny")) {
#     stop("`shiny` package is not installed.", call. = FALSE)
#   }
#   shiny::runApp(appDir, display.mode = "normal")
# }
