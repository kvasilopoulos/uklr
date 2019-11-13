

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

sql_build <- function(...) {
  paste(..., collapse = "")
}

sql_select <- function(..., type = NULL) {
  paste("Select", type)
}


# query pattern -----------------------------------------------------------


sparql_filter <- function(...) {
  c(...) %!||%
    paste("Filter (", paste(c(...), collapse = " && "), ")")
}

sparql_filter_start_date <- function(start_date) {
  start_date %!||%
    paste("?dateStr >=", shQuote(start_date, "csh"), "^^xsd:date")
}

sparql_filter_end_date <- function(end_date) {
  end_date %!||%
    paste("?dateStr <=", shQuote(end_date, "csh"), "^^xsd:date")
}

sparql_filter_region <- function(region) {
  inner <- region %!||%
    paste0("regex(str(?region), ", shQuote(region, "csh"), ", 'i' )",
           collapse = "||")
  region %!||%
    paste0("(", inner, ")")
}

rdf_optional <- function(optional) {
  optional %!||%
    paste("Optional {", optional, "}", sep = ";")
}


# Query modifiers ---------------------------------------------------------


rdf_modifiers <- function(...) {
  paste(..., collapse = " ")
}

sparql_order_by <- function(order_by) {
  order_by %!||%
    paste("Order By", paste0("?", order_by, collapse = " "))
}

sparql_limit <- function(limit) {
  limit %!||%
    paste("Limit", limit)
}

sparql_offset <- function(offset) {
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

uktrans_build_sparql_query <- function() {

}

uktrans_sparql <- function() {

}

# ukppd -------------------------------------------------------------------

ukppd_build_sparql_query <-
  function(.postcode, .item, .optional_item, .start_date, .end_date) {
    ukppd_sparql_select(
      postcode = .postcode, item = .item, optional_item = .optional_item,
      sparql_filter(
        sparql_filter_start_date(.start_date),
        sparql_filter_end_date(.end_date)
      )
    )
  }

ukppd_sparql_select <- function(..., postcode, item, optional_item ) {
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
  order_by <- "ORDER BY ?postcode ?dateStr ?amount"
  paste(slct, "where {", values, addr_postcode, transx,
        lrppi_item, ..., "}", order_by)
}

# assertion ukppd ---------------------------------------------------------

assert_valid_ukppd_categories <- function(x) {
  if (x %ni% ukppd_avail_categories())
    stop("invalid category name", call. = FALSE)
}

assert_valid_ukppd_optional_categories <- function(x) {
  if (x %ni% ukppd_avail_optional_categories())
    stop("invalid category name", call. = FALSE)
}

# ukhp --------------------------------------------------------------------


ukhp_build_sparql_query <- function(.item = NULL, .extra = NULL, .region = NULL,
                                    .start_date = NULL, .end_date = NULL) {
  ukhp_sparql_select(
    item = .item, extra = .extra,
    sparql_filter(
      sparql_filter_start_date(.start_date),
      sparql_filter_end_date(.end_date),
      sparql_filter_region(.region)
    )
  )
}

ukhp_sparql_select <- function(..., item, extra) {
  base_item <- "?region (STR(?dateStr) as ?date) ?housePriceIndex"
  categ_item <- item %!||%
    paste0("?", item, collapse = " ")
  slct <- paste("Select", extra, base_item, categ_item)

  init_alloc <- "?region ukhpi:refPeriodStart ?dateStr;
  ukhpi:housePriceIndex ?housePriceIndex;"
  ukhpi_item <- item %!||%
    paste0("ukhpi:", item, " ?", item, collapse = "; ")
  order_by <- "ORDER BY ?region ?date"
  paste(slct, "where {", init_alloc, ukhpi_item, ..., "}", order_by)
}


# assertions ukhp -----------------------------------------------------------

assert_valid_ukhp_item <- function(x) {
  if (x %ni% ukhp_avail_items())
    stop("invalid category name", call. = FALSE)
}

assert_valid_ukhp_region <- function(x) {
  if (x %ni% ukhp_avail_regions())
    stop("invalid region name", call. = FALSE)
}
