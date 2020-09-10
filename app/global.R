specify_buttons <- function(filename) {
  list(
    list(
      extend = "collection",
      buttons =
        list(
          list(
            extend = 'csv',
            filename = filename,
            exportOptions = list(
              modifier = list(
                page = "all",
                search = 'none')
            )
          ),
          list(
            extend = 'excel',
            filename = filename)
        ),
      text = "Download"
    )
  )
}
