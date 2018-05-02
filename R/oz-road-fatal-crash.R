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
#'   \item{`Date`}{Date, Year, Month and Day. This is the date of the crash}
#'   \item{`Months`}{Integer, the month of the date of the crash}
#'   \item{`year`}{Integer, the year of the date of the crash}
#'   \item{`weekday`}{Text the weekday of the date of the crash}
#'   \item{`time`}{Time, the time of the date of the crash}
#'   \item{`crash_type`}{Character, Code summarising the type of type of crash. Single, Multiple, or Pedestrian}
#'   \item{`n_fatalities`}{Integer, number of killed persons in the crash}
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
  dat_fatal_crash_raw <- readr::read_csv("https://bitre.gov.au/statistics/safety/files/Fatal_Crashes_September_2017.csv")
))

  dat_fatal_crash_clean <- dat_fatal_crash_raw %>%
    janitor::clean_names() %>%
    dplyr::rename(weekday = dayweek,
                  n_fatalities = number_of_fatalities,
                  bus = bus_involvement,
                  heavy_rigid_truck = heavy_rigid_truck_involvement,
                  articulated_truck = articulated_truck_involvement) %>%
    dplyr::mutate(date = lubridate::dmy(date)) %>%
    dplyr::mutate(date_time = paste(date,time)) %>%
    dplyr::mutate(date_time = lubridate::as_datetime(date_time))

dat_fatal_crash_clean

}
