context("build-sparql")

skip_if_offline()
skip_if_http_error()

test_that("basic query", {
  expect_error(ukhp_get(), NA)
  expect_error(ukppd_get(), NA)
  expect_error(uktrans_get(), NA)
})


test_that("wrong queries", {
  expect_error(ukhp_get(region = "wrong-region"))
  expect_error(ukhp_get(item = "wrong-item"))

  expect_error(ukppd_get(postcode = "wrong-postcode"))
  expect_error(ukppd_get(item = "wrong-item"))
  expect_error(ukppd_get(optional = "wrong-optional-item"))
  expect_error(uktrans_get(item = "wrong-item"))
  expect_error(uktrans_get(region = "wrong-region"))
})

test_that("avail",{
  expect_equal(ukhp_avail_items_ref(),
         c("refMonth", "refRegion", "refPeriodStart", "refPeriodDuration"))
  expect_error(ukhp_avail_date_last(), NA)
  expect_error(ukhp_avail_date_span(), NA)
})

test_that("ons", {


  # expect_error(ons_lookup(), NA)
  # expect_error(ons_countries(), NA)
  # expect_error(ons_regions(), NA)
  # expect_error(ons_eng_counties(), NA)
  # expect_error(ons_la(), NA)
  #
  # expect_error(ons_nuts1(), NA)
  # expect_error(ons_nuts2(), NA)
  # expect_error(ons_nuts3(), NA)
  # expect_error(ons_lad(), NA)
  expect_error(ons_pc(), NA)
})

test_that("def",{
  expect_error(uklr_def(), NA)
  expect_error(ukhp_def(), NA)
  expect_error(ukppd_def(), NA)
  expect_error(uktrans_def(), NA)
})

test_that("browse", {
  skip_if_interactive()
  expect_equal(uklr_browse(), "http://landregistry.data.gov.uk")
  expect_equal(ukhp_browse(), "http://landregistry.data.gov.uk/def/ukhpi")
  expect_equal(ukppd_browse(), "http://landregistry.data.gov.uk/def/ppi")
  expect_equal(uktrans_browse(), "http://landregistry.data.gov.uk/def/trans")
})

test_that("single transaction is handled correctly (Issue #5)", {
  result <- ukppd_get("N13 5UR")
  expect_s3_class(result, "tbl_df")
  expect_equal(ncol(result), 4)
  expect_true("postcode" %in% names(result))
  expect_true("amount" %in% names(result))
  expect_true("date" %in% names(result))
  expect_true("category" %in% names(result))
})

test_that("multiple transactions are handled correctly", {
  result <- ukppd_get("PL6 8RU")
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 0)
  expect_equal(ncol(result), 4)
})
