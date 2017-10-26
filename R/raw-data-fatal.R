
# get_oz_fatal_crash <- function(){
suppressMessages(
suppressWarnings(
  dat_fatal_raw <- readr::read_csv("https://bitre.gov.au/statistics/safety/files/Fatalities_September_2017.csv")
)
)
  # dat_fatal_clean <- dat_fatal_raw %>%
  dat_fatal_raw %>%
    janitor::clean_names() %>%
    dplyr::mutate(date = paste0(year,"-",month,"-",day),
                  weekday = lubridate::wday(date, label = TRUE, abbr = TRUE),
                  time = paste0(hour,":",minute),
                  time = lubridate::as_datetime(time)) %>% View()
    dplyr::rename(crash_id = crashid
                  weekday = dayweek,
                  n_fatalities = number_of_fatalities,
                  bus = bus_involvement,
                  heavy_rigid_truck = heavy_rigid_truck_involvement,
                  articulated_truck = articulated_truck_involvement) %>%
    dplyr::mutate(date = lubridate::dmy(date)) %>%
    dplyr::mutate(date_time = paste(date,time)) %>%
    dplyr::mutate(date_time = lubridate::as_datetime(date_time))

  dat_fatal_clean

# }
