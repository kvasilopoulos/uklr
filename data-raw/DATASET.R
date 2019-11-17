library(tidyverse)

# POSTAL CODE TO NUTS3
download.file("http://ec.europa.eu/eurostat/tercet/download.do?file=pc2018_uk_NUTS-2016_v2.0.zip",
              "data-raw/zip_pc.zip")
unzip("data-raw/zip_pc.zip", exdir = "data-raw")

pc <- readr::read_csv2("data-raw/pc2018_uk_NUTS-2016_v2.0.csv") %>%
  mutate_all(~ gsub("[']", "", .)) %>%
  set_names(c("NUTS318CD", "PC"))

usethis::use_data(pc, overwrite = TRUE, compress = "xz")
