

library(tidyverse)

dat_fatal_crash_raw <- readr::read_csv("https://bitre.gov.au/statistics/safety/files/Fatal_Crashes_September_2017.csv")

dat_fatal_crash_clean <- dat_fatal_crash_raw %>%
  janitor::clean_names() %>%
  rename(crash_id = crashid,
         weekday = dayweek,
         n_fatalities = number_of_fatalities,
         bus = bus_involvement,
         heavy_rigid_truck = heavy_rigid_truck_involvement,
         articulated_truck = articulated_truck_involvement) %>%
  mutate(date = lubridate::dmy(date)) %>%
  mutate(date_time = paste(date,time)) %>%
  mutate(date_time = lubridate::as_datetime(date_time))
