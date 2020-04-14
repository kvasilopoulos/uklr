skip_if_offline()
skip_if_http_error()

test_that("emprty dataframe", {
  expect_error(ukhp_get(limit = 0), "empty dataframe, check your query!")
})
