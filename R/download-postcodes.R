
# POSTAL CODE TO NUTS3
down_postcodes <- function(){
  download.file("http://ec.europa.eu/eurostat/tercet/download.do?file=pc2018_uk_NUTS-2016_v2.0.zip",
                "data-raw/zip_pc.zip")
  unzip("data-raw/zip_pc.zip", exdir = "data-raw")

  internal_postcodes_2018 <- readr::read_csv2("data-raw/pc2018_uk_NUTS-2016_v2.0.csv") %>%
    dplyr::mutate_all(~ gsub("[']", "", .)) %>%
    purrr::set_names(c("NUTS3", "PC"))

  usethis::use_data(internal_postcodes_2018, overwrite = TRUE, compress = "xz")


}
