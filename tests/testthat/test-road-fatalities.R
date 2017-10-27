context("Road-fatalities")

dat_road_fatalities <- oz_road_fatalities()

test_that("test that there are exactly 48266 rows", {
  expect_equal(nrow(dat_road_fatalities),48266)
})

test_that("test that there are exactly 14 columns", {
  expect_equal(ncol(dat_road_fatalities),14)
})

test_that("test that there the names are the same", {
  expect_equal(names(dat_road_fatalities),
               c("crash_id",
                 "date_time",
                 "month",
                 "weekday",
                 "time",
                 "state",
                 "crash_type",
                 "bus",
                 "heavy_rigid_truck",
                 "articulated_truck",
                 "speed_limit",
                 "road_user",
                 "gender",
                 "age"))
})
