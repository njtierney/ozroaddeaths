#' Get the australian fatal crash data
#'
#' @return a dataset (tibble) of fatal crash data
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_oz_fatal_crash()
#' }
get_oz_fatal_crash <- function(){

  dat_fatal_crash_raw <- readr::read_csv("https://bitre.gov.au/statistics/safety/files/Fatal_C
                                         ashes_September_2017.csv")

dat_fatal_crash_clean <- dat_fatal_crash_raw %>%
  janitor::clean_names() %>%
  dplyr::rename(crash_id = crashid,
         weekday = dayweek,
         n_fatalities = number_of_fatalities,
         bus = bus_involvement,
         heavy_rigid_truck = heavy_rigid_truck_involvement,
         articulated_truck = articulated_truck_involvement) %>%
  dplyr::mutate(date = lubridate::dmy(date)) %>%
  dplyr::mutate(date_time = paste(date,time)) %>%
  dplyr::mutate(date_time = lubridate::as_datetime(date_time))

dat_fatal_crash_clean

}
