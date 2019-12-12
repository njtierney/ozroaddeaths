#' Retrieve Australian Fatal Crash Data
#'
#' This function pulls data from the Australian Road Deaths Database.
#'     Specifically, the details regarding the persons killed, for
#'     example, age, gender and road user group.
#'
#' @return a dataset (tibble) of fatal crash data
#'
#' \describe{
#'   \item{`crash_id`}{An integer, 13 digits, unique to each crash}
#'   \item{`state`}{Text, Austraian jurisdiction, Abbreviation for each state and territory. QLD = Queensland, NSW = New South Wales, ACT = Australian Capital Territory, VIC = Victoria, TAS = TASMANIA, SA = South Australia, WA = Western Australian, NT = Northern Territory}
#'   \item{`Date`}{Date, Year, Month and Day. This is the date of the crash, but with unknown day so set to the 1st}
#'   \item{`Months`}{Integer, the month of the date of the crash}
#'   \item{`year`}{Integer, the year of the date of the crash}
#'   \item{`weekday`}{Text the weekday of the date of the crash}
#'   \item{`time`}{Time, the time of the date of the crash}
#'   \item{`crash_type`}{Character, Code summarising the type of type of crash. Single, Multiple, or Pedestrian}
#'   \item{`n_fatalities`}{Integer, number of killed persons in the crash}
#'   \item{`bus`}{logical - whether a bus was involved in the crash (TRUE) or not (FALSE)}
#'   \item{`heavy_rigid_truck`}{logical - whether a heavy rigid truck was involved in the crash (TRUE) or not (FALSE)}
#'   \item{`articualated_truck`}{logical - whether a articulated trucl was involved in the crash (TRUE) or not (FALSE)}
#'   \item{`speed_limit`}{Integer, posted speed limit at the location of crash}
#'   \item{`road_user`}{Text, Type of person killed. Driver, Passenger, Pedestrian, Motorcycle Rider, Motorcycle Passenger, Bicyclist (including pillion passengers)}
#'   \item{`gender`}{Text, Biological Sex of person killed, Male, Female, Unknown}
#'   \item{`age`}{Integer, Age of person killed, in years}}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' oz_road_fatalities
#' }
oz_road_fatalities <- function() {
  suppressMessages(suppressWarnings(
    dat_fatal_raw <-readr::read_csv("https://data.gov.au/data/dataset/5b530fb8-526e-4fbf-b0f6-aa24e84e4277/resource/fd646fdc-7788-4bea-a736-e4aeb0dd09a8/download/ardd_fatalities.csv"
)
  ))

  dat_fatal_clean <- dat_fatal_raw %>%
    janitor::clean_names() %>%
    dplyr::mutate(date = lubridate::make_date(year, month, 1),
                  date_time = lubridate::as_datetime(paste(date,time))) %>%
    dplyr::rename(bus = bus_involvement,
                  weekday = dayweek,
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
                  age) %>%
    purrr::map(~ ifelse(.x %in% na_values_to_replace, NA, .x))


  dat_fatal_clean

}
