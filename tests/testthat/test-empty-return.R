skip_if_offline()
skip_if_http_error()

test_that("emprty dataframe", {
  empty_msg <- "empty dataframe, check your query!"
  expect_warning(ukhp_get(limit = 0), empty_msg)
  expect_warning(ukhp_get(start_date = "2100-01-01"), empty_msg)
})
