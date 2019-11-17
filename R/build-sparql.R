

# result clause -----------------------------------------------------------

build_sparql_file_query <- function(...) {
  slct <- "Select * where"
  assign_names <- "?type ?value"
  paste0(slct, "{", sparql_file(...), assign_names, "}")
}

sparql_file <- function(...) {
  base_url <- "http://landregistry.data.gov.uk/data"
  full_url <- paste(base_url, ..., sep = "/")
  paste0("<", full_url, ">")
}

# sql_build <- function(...) {
#   paste(..., collapse = "")
# }

# sql_select <- function(..., type = NULL) {
#   paste("Select", type)
# }


# query pattern -----------------------------------------------------------


build_sparql_filter <- function(...) {
  c(...) %!||%
    paste("Filter (", paste(c(...), collapse = " && "), ")")
}

build_sparql_filter_start_date <- function(start_date) {
  start_date %!||%
    paste("?dateStr >=", shQuote(start_date, "csh"), "^^xsd:date")
}

build_sparql_filter_end_date <- function(end_date) {
  end_date %!||%
    paste("?dateStr <=", shQuote(end_date, "csh"), "^^xsd:date")
}

build_sparql_filter_region <- function(region) {
  inner <- region %!||%
    paste0("regex(str(?region), ", shQuote(region, "csh"), ", 'i' )",
           collapse = "||")
  region %!||%
    paste0("(", inner, ")")
}

# rdf_optional <- function(optional) {
#   optional %!||%
#     paste("Optional {", optional, "}", sep = ";")
# }


# Query modifiers ---------------------------------------------------------


rdf_modifiers <- function(order_by = NULL, limit = NULL, offset = NULL) {
  paste(
    build_sparql_order_by(order_by),
    build_sparql_limit(limit),
    build_sparql_offset(offset),
    collapse = " ")
}

# order_by <- "third desc(cos) third asc(mpla) "

fix_order <- function(x) {
  splited <- strsplit(x, " ")[[1]]
  has_ordering <- grepl("\\(", splited)
  ordering <- gsub("\\(.*", "\\", splited[has_ordering])
  vars <- gsub(".*\\((.*)\\).*", "\\1", splited)
  ordered_vars <- paste0(ordering, "(?", vars[has_ordering], ")")
  unordered_vars <- paste0("?", vars[!has_ordering])

  fvars <- character(length = length(vars))
  fvars[has_ordering] <- ordered_vars
  fvars[!has_ordering] <- unordered_vars
  paste(fvars, collapse = " ")
}

build_sparql_order_by <- function(order_by) {
  order_by %!||%
    paste("Order By", fix_order(order_by))
}

build_sparql_limit <- function(limit) {
  limit %!||%
    paste("Limit", limit)
}

build_sparql_offset <- function(offset) {
  offset %!||%
    paste("Offset", offset)
}

# assert generic ----------------------------------------------------------


assert_valid_date_format <- function(x) {
  date_format <- as.Date(x, "%Y%m%d")
  if (is.na(date_format))
    stop("invalid date format")
}

# uktrans -----------------------------------------------------------------

uktrans_build_sparql <-
  function(.item, .region, .start_date, .end_date, ...) {
    uktrans_build_sparql_query(
      item = .item,
      build_sparql_filter(
        build_sparql_filter_start_date(.start_date),
        build_sparql_filter_end_date(.end_date),
        build_sparql_filter_region(.region)
      ),
      modifiers = rdf_modifiers(...)
    )
}

uktrans_build_sparql_query <- function(..., item, modifiers) {
  base_item <- "?region ?date"
  categ_item <- item %!||%
    paste0("?", item, collapse = " ")
  slct <- paste("Select", base_item, categ_item)

  type_base <- "?type trans:regionName ?region; trans:countPeriod ?dt;"
  transx_item <- item %!||%
    paste0("trans:", item, " ?", item, collapse = "; ")
  bind_date <- "bind(concat(str(year(?dt)),'-', str(month(?dt)), '-01') as ?date)"
  whr <- paste(type_base, transx_item, bind_date)

  paste(slct, "where {",  whr, ..., "}", modifiers)
}

# ukppd -------------------------------------------------------------------

ukppd_build_sparql <-
  function(.postcode, .item, .optional_item, .start_date, .end_date, ...) {
    ukppd_build_sparql_query(
      postcode = .postcode, item = .item, optional_item = .optional_item,
      build_sparql_filter(
        build_sparql_filter_start_date(.start_date),
        build_sparql_filter_end_date(.end_date)
      ),
      modifiers = rdf_modifiers(...)
    )
  }

ukppd_build_sparql_query <- function(..., postcode, item, optional_item, modifiers) {
  base_item <- "?postcode ?amount (STR(?dateStr) as ?date) ?category"
  categ_item <- item %!||%
    paste0("?", item, collapse = " ")
  slct_optional_item <- optional_item %!||%
    paste0("?", optional_item, collapse = " ")
  slct <- paste("Select", base_item, categ_item, slct_optional_item)

  postcode_values <-
    paste0("(", shQuote(postcode, "csh"), "^^xsd:string)", collapse = " ")
  values <- paste0('VALUES (?postcode) {', postcode_values, '}')

  addr_postcode <- "?addr lrcommon:postcode ?postcode."
  transx_base <- "?transx lrppi:propertyAddress ?addr ;"
  transx_item <- "lrppi:pricePaid ?amount ; lrppi:transactionDate ?dateStr ;
  lrppi:transactionCategory/skos:prefLabel ?category"
  transx <- paste(transx_base, transx_item)
  lrppi_item <- optional_item %!||%
    paste0("lrppi:", optional_item, " ?", item, collapse = "; ")
  whr <- paste(values, addr_postcode, transx, lrppi_item)

  paste(slct, "where {", whr, ..., "}", modifiers)
}

# ukhp --------------------------------------------------------------------


ukhp_build_sparql <- function(.item = NULL, .extra = NULL, .region = NULL,
                                    .start_date = NULL, .end_date = NULL, ...) {
  ukhp_build_sparql_query(
    item = .item,
    extra = .extra,
    build_sparql_filter(
      build_sparql_filter_start_date(.start_date),
      build_sparql_filter_end_date(.end_date),
      build_sparql_filter_region(.region)
    ),
    modifiers = rdf_modifiers(...)
  )
}


ukhp_build_sparql_query <- function(..., item, extra, modifiers) {
  base_item <- "?region (STR(?dateStr) as ?date) ?housePriceIndex"
  categ_item <- item %!||%
    paste0("?", item, collapse = " ")
  slct <- paste("Select", extra, base_item, categ_item)

  init_alloc <- "?region ukhpi:refPeriodStart ?dateStr;"
  ukhpi_item <- item %!||%
    paste0("ukhpi:", item, " ?", item, collapse = "; ")
  paste(slct, "where {", init_alloc, ukhpi_item, ..., "}", modifiers)
}


