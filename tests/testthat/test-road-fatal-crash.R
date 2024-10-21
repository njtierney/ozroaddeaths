dat_road_fatal_crash <- oz_road_fatal_crash()

test_that("test that the fatal crash dimensions are stable", {
  expect_snapshot(dim(dat_road_fatal_crash))
})

test_that("test names of fatal crash are the same", {
  expect_snapshot(names(dat_road_fatal_crash))
})

test_that("classes are consistent", {
  expect_snapshot(classes(dat_road_fatal_crash))
})
