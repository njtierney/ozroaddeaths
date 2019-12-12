#' Retrieve Australian Fatal Crash Data
#'
#' This function pulls data from the Australian Road Deaths Database,
#'     specifically, the circumstances of the crash, for example, date,
#'     location, crash type.
#'
#' @return a dataset (tibble) of fatal crash data
#'
#' Format: a data frame with 43,345 observations on the following 14
#' variables.
#' \describe{
#'   \item{`crash_id`}{An integer, 13 digits, unique to each crash}
#'   \item{`state`}{Text, Austraian jurisdiction, Abbreviation for each state and territory. QLD = Queensland, NSW = New South Wales, ACT = Australian Capital Territory, VIC = Victoria, TAS = TASMANIA, SA = South Australia, WA = Western Australian, NT = Northern Territory}
#'   \item{`Date`}{Date, Year, Month. This is the date of the crash, but with unknown date (set to 1st)}
#'   \item{`Months`}{Integer, the month of the date of the crash}
#'   \item{`year`}{Integer, the year of the date of the crash}
#'   \item{`weekday`}{Text the weekday of the date of the crash}
#'   \item{`time`}{Time, the time of the date of the crash}
#'   \item{`n_fatalities`}{Integer, number of killed persons in the crash}
#'   \item{`crash_type`}{Character, Code summarising the type of type of crash. Single, Multiple, or Pedestrian}
#'   \item{`bus`}{logical - whether a bus was involved in the crash (TRUE) or not (FALSE)}
#'   \item{`heavy_rigid_truck`}{logical - whether a heavy rigid truck was involved in the crash (TRUE) or not (FALSE)}
#'   \item{`articualated_truck`}{logical - whether a articulated trucl was involved in the crash (TRUE) or not (FALSE)}
#'   \item{`speed_limit`}{Integer, posted speed limit at the location of crash}}
#' @source \url{https://bitre.gov.au/statistics/safety/fatal_road_crash_database.aspx}
#' @examples
#' \dontrun{
#' oz_road_fatal_crash
#' }
#' @export
oz_road_fatal_crash <- function(){

  suppressMessages(suppressWarnings(
  dat_fatal_crash_raw <- readr::read_csv("https://data.gov.au/data/dataset/5b530fb8-526e-4fbf-b0f6-aa24e84e4277/resource/d54f7465-74b8-4fff-8653-37e724d0ebbb/download/ardd_fatal_crashes.csv")
  ))

  dat_fatal_crash_clean <- dat_fatal_crash_raw %>%
    janitor::clean_names() %>%
    dplyr::rename(weekday = dayweek,
                  n_fatalities = number_fatalities,
                  bus = bus_involvement,
                  heavy_rigid_truck = heavy_rigid_truck_involvement,
                  articulated_truck = articulated_truck_involvement) %>%
    dplyr::mutate(date = lubridate::make_date(year, month, 1),
                  date_time = lubridate::as_datetime(paste(date,time))) %>%
    dplyr::select(crash_id,
                  date,
                  n_fatalities,
                  date_time,
                  month,
                  year,
                  weekday,
                  time,
                  state,
                  crash_type,
                  bus,
                  heavy_rigid_truck,
                  articulated_truck,
                  speed_limit) %>%
    naniar::replace_with_na_all(condition = ~.x == -9)

dat_fatal_crash_clean

}
