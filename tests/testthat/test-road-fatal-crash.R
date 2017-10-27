context("Road-fatal-crash")

dat_road_fatal_crash <- oz_road_fatal_crash()

test_that("test that there are exactly 43345 rows", {
  expect_equal(nrow(dat_road_fatal_crash),43345)
})

test_that("test that there are exactly 14 columns", {
  expect_equal(ncol(dat_road_fatal_crash),14)
})

test_that("test that there the names are the same", {
  expect_equal(names(dat_road_fatal_crash),
               c("crash_id",
                 "state",
                 "date",
                 "month",
                 "year",
                 "weekday",
                 "time",
                 "crash_type",
                 "n_fatalities",
                 "bus",
                 "heavy_rigid_truck",
                 "articulated_truck",
                 "speed_limit",
                 "date_time"))
})

