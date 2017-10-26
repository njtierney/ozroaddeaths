#' Retrieve the data of fatalities from Australian Road Deaths Database
#'
#'
#'
#' @return a data.frame
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_oz_fatal()
#' }
get_oz_fatal <- function() {
  suppressMessages(suppressWarnings(
    dat_fatal_raw <-readr::read_csv(
        "https://bitre.gov.au/statistics/safety/files/Fatalities_September_2017.csv"
      )
  ))

  dat_fatal_clean <- dat_fatal_raw %>%
    janitor::clean_names() %>%
    dplyr::mutate(date_time = ISOdatetime(year = year,
                                          month = month,
                                          day = day,
                                          hour = hour,
                                          min = minute,
                                          sec = 0,
                                          tz = "UTC"),
                  weekday = lubridate::wday(date_time, label = TRUE, abbr = FALSE),
                  month = lubridate::month(date_time, label = TRUE, abbr = FALSE),
                  time = format(date_time, "%H:%M")) %>%
    dplyr::rename(crash_id = crashid,
                  bus = bus_involvement,
                  heavy_rigid_truck = heavy_rigid_truck_involvement,
                  articulated_truck = articulated_truck_involvement) %>%
    dplyr::select(crash_id,
                  date_time,
                  month,
                  weekday,
                  time,
                  state,
                  crash_type,
                  bus,
                  heavy_rigid_truck,
                  articulated_truck,
                  speed_limit,
                  road_user,
                  gender,
                  age)

  dat_fatal_clean

}
