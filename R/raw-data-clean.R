#' Get the australian fatal crash data
#'
#' @return a dataset (tibble) of fatal crash data
#'
#' Format: a data frame with 43,345 observations on the following 14
#' variables.
#' \describe{
#'   \item{`crash_id`}{An integer, 13 digits, unique to each crash}
#'   \item{`state`}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#'   \item{``}{}
#' @source \url{https://bitre.gov.au/statistics/safety/fatal_road_crash_database.aspx}
#' @export
#'


#' @examples
#' \dontrun{
#' get_oz_fatal_crash()
#' }
get_oz_fatal_crash <- function(){

  dat_fatal_crash_raw <- readr::read_csv("https://bitre.gov.au/statistics/safety/files/Fatal_Crashes_September_2017.csv")

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
