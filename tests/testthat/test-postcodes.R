skip_if_offline()
skip_if_http_error()

test_that("internal postcodes", {
  pc = ukppd_avail_postcodes()
  expect_true(isa(pc, "character"))
})
