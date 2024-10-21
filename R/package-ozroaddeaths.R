#' ozroaddeaths
#'
#' ozroaddeaths is a package that pulls data from the Australian Road Deaths
#'     Database, run by the Bureau of Infrastructure, Transport and Regional
#'     Economics (BITRE). This provides basic details of road transport crash
#'     fatalities in Australia as reported by the police each month to the State
#'     and Territory road safety authorities. The details provided in the
#'     database fall into two groups: 1) the circumstances of the crash, for
#'     example, date, location, crash type some details regarding the persons
#'     killed, for example, age, gender and road user group.
#'
#' @name ozroaddeaths
"_PACKAGE"

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
globalVariables(
  c("crashid",
    "dayweek",
    "number_of_fatalities",
    "bus_involvement",
    "heavy_rigid_truck_involvement",
    "articulated_truck",
    "articulated_truck_involvement",
    "bus",
    "bus_involvement",
    "crash_id",
    "crash_type",
    "date_time",
    "day",
    "dayweek",
    "gender",
    "heavy_rigid_truck",
    "hour",
    "minute",
    "month",
    "n_fatalities",
    "number_fatalities",
    "road_user",
    "speed_limit",
    "time",
    "weekday",
    "year",
    "state",
    "age"
  )
)

