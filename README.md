
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ozroaddeaths [![Travis-CI Build Status](https://travis-ci.org/ropenscilabs/ozroaddeaths.svg?branch=master)](https://travis-ci.org/ropenscilabs/ozroaddeaths) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropenscilabs/ozroaddeaths?branch=master&svg=true)](https://ci.appveyor.com/project/ropenscilabs/ozroaddeaths)

ozroaddeaths is a package that pulls data from the Australian Road
Deaths Database, run by the Bureau of Infrastructure, Transport and
Regional Economics (BITRE). This provides basic details of road
transport crash fatalities in Australia as reported by the police each
month to the State and Territory road safety authorities. The details
provided in the database fall into two groups:

1.  The circumstances of the crash, for example, date, location, crash
    type

2.  Some details regarding the persons killed, for example, age, gender
    and road user group.

## Installation

You can install ozroaddeaths from github with:

``` r
# install.packages("devtools")
devtools::install_github("ropenscilabs/ozroaddeaths")
```

This data is taken from the Australian Road Deaths Database, which
provides basic details of road transport crash fatalities in Australia
as reported by the police each month to the State and Territory road
safety authorities, obtained from:
<https://data.gov.au/dataset/ds-dga-5b530fb8-526e-4fbf-b0f6-aa24e84e4277/details?q=crash>

Details provided in the database fall into two groups:

  - the circumstances of the crash, for example, date, location, crash
    type

  - some details regarding the persons killed, for example, age, gender
    and road user group.

The fatality data is updated every month. The heavy vehicle flags (for
articulated truck, heavy rigid truck and bus involvement) are only
updated each quarter, and are current to within two months. Information
for heavy rigid truck involvement in crashes earlier than 2004 is
incomplete. There is no day of the month for the data, so we have
imputed this as the first of the month.

## Package Author’s Notes

Data was available at URL as at 13th December 2019. Data is imported
into R and cleaned by removing redundant date columns and transforming
into a tidy format.

### Indemnity Statement:

The Bureau of Infrastructure, Transport and Regional Economics has taken
due care in preparing this information. However, noting that data have
been provided by third parties, the Commonwealth gives no warranty as to
the accuracy, reliability, fitness for purpose, or otherwise of the
information.

Copyright

© Commonwealth of Australia, 2017

This work is copyright and the data contained in this publication should
not be reproduced or used in any form without acknowledgement.

## Import data from the BITRE website into R

``` r
library(ozroaddeaths)
library(dplyr)
library(ggplot2)
library(lubridate)
library(ggridges)
```

``` r
crashes <- oz_road_fatal_crash() 
fatalities <- oz_road_fatalities()
```

## Variables available

### Crashes

``` r
knitr::kable(dplyr::as_data_frame(names(crashes)))
#> Warning: `as_data_frame()` is deprecated, use `as_tibble()` (but mind the new semantics).
#> This warning is displayed once per session.
```

| value               |
| :------------------ |
| crash\_id           |
| n\_fatalities       |
| month               |
| year                |
| weekday             |
| time                |
| state               |
| crash\_type         |
| bus                 |
| heavy\_rigid\_truck |
| articulated\_truck  |
| speed\_limit        |
| date                |
| date\_time          |

``` r
knitr::kable(head(crashes))
```

| crash\_id | n\_fatalities | month | year | weekday   | time     | state | crash\_type | bus | heavy\_rigid\_truck | articulated\_truck | speed\_limit | date       | date\_time          |
| --------: | ------------: | ----: | ---: | :-------- | :------- | :---- | :---------- | :-- | :------------------ | :----------------- | -----------: | :--------- | :------------------ |
|  20193047 |             1 |    10 | 2019 | Thursday  | 11:00:00 | Qld   | Single      | No  | No                  | No                 |          100 | 2019-10-01 | 2019-10-01 11:00:00 |
|  20192202 |             1 |    10 | 2019 | Thursday  | 21:06:00 | Vic   | Pedestrian  | NA  | NA                  | NA                 |           NA | 2019-10-01 | 2019-10-01 21:06:00 |
|  20191179 |             1 |    10 | 2019 | Wednesday | 06:45:00 | NSW   | Pedestrian  | No  | No                  | No                 |           50 | 2019-10-01 | 2019-10-01 06:45:00 |
|  20192073 |             1 |    10 | 2019 | Wednesday | 07:15:00 | Vic   | Single      | NA  | NA                  | NA                 |           NA | 2019-10-01 | 2019-10-01 07:15:00 |
|  20193053 |             1 |    10 | 2019 | Tuesday   | 15:00:00 | Qld   | Multiple    | No  | Yes                 | No                 |          100 | 2019-10-01 | 2019-10-01 15:00:00 |
|  20192029 |             1 |    10 | 2019 | Tuesday   | 12:03:00 | Vic   | Multiple    | NA  | Yes                 | NA                 |          100 | 2019-10-01 | 2019-10-01 12:03:00 |

### Fatalities

``` r
knitr::kable(dplyr::as_data_frame(names(fatalities)))
```

| value               |
| :------------------ |
| crash\_id           |
| month               |
| year                |
| weekday             |
| time                |
| state               |
| crash\_type         |
| bus                 |
| heavy\_rigid\_truck |
| articulated\_truck  |
| speed\_limit        |
| road\_user          |
| gender              |
| age                 |
| date                |
| date\_time          |

``` r
knitr::kable(head(fatalities))
```

| crash\_id | month | year | weekday   | time     | state | crash\_type | bus | heavy\_rigid\_truck | articulated\_truck | speed\_limit | road\_user       | gender | age | date       | date\_time          |
| --------: | ----: | ---: | :-------- | :------- | :---- | :---------- | :-- | :------------------ | :----------------- | -----------: | :--------------- | :----- | --: | :--------- | :------------------ |
|  20193047 |    10 | 2019 | Thursday  | 11:00:00 | Qld   | Single      | No  | No                  | No                 |          100 | Driver           | Male   |  25 | 2019-10-01 | 2019-10-01 11:00:00 |
|  20192202 |    10 | 2019 | Thursday  | 21:06:00 | Vic   | Pedestrian  | NA  | NA                  | NA                 |           NA | Pedestrian       | Female |  64 | 2019-10-01 | 2019-10-01 21:06:00 |
|  20191179 |    10 | 2019 | Wednesday | 06:45:00 | NSW   | Pedestrian  | No  | No                  | No                 |           50 | Pedestrian       | Female |  81 | 2019-10-01 | 2019-10-01 06:45:00 |
|  20192073 |    10 | 2019 | Wednesday | 07:15:00 | Vic   | Single      | NA  | NA                  | NA                 |           NA | Passenger        | Male   |  25 | 2019-10-01 | 2019-10-01 07:15:00 |
|  20193053 |    10 | 2019 | Tuesday   | 15:00:00 | Qld   | Multiple    | No  | Yes                 | No                 |          100 | Motorcycle rider | Male   |  35 | 2019-10-01 | 2019-10-01 15:00:00 |
|  20191220 |    10 | 2019 | Tuesday   | 06:40:00 | NSW   | Multiple    | Yes | No                  | No                 |           80 | Motorcycle rider | Male   |  28 | 2019-10-01 | 2019-10-01 06:40:00 |

### Plot crashes by year

``` r
crash_plot <- ggplot(crashes,
                     aes(x = year,
                         fill = year)) +
  geom_line(stat = "count") +
  theme_minimal() +
  ggtitle("Annual number of fatal car accidents per year")

crash_plot
```

![](README-crash%20plot%20by%20year-1.png)<!-- -->

### Plot crashes by year and state

``` r

crash_plot +
  scale_y_continuous(trans = "log2") +
  facet_wrap(~state) +
   ggtitle("Annual number of fatal car accidents per year and state",
           subtitle = "log2 scale" )
```

![](README-crash%20plot%20by%20year%20and%20state-1.png)<!-- -->

### Fatalities by year

``` r

fatality_plot <- fatalities %>%
  mutate(year = lubridate::year(date_time)) %>%
  ggplot(aes(x =  year, 
             fill = year)) +
  geom_line(stat = "count") +
  theme_minimal() +
  ggtitle("Annual number of road fatalities")

fatality_plot
```

![](README-fatalities%20plot%20by%20year-1.png)<!-- -->

``` r

fatality_plot <- fatalities %>%
  filter(gender != "Unspecified") %>%
  mutate(year = lubridate::year(date_time)) %>%
  ggplot(aes(x = age, 
             fill = gender )) +
  geom_density() +
  facet_wrap(~gender) +
  theme_minimal() +
  ggtitle("Distribution of road fatalities by age 1989 to 2017")

fatality_plot
#> Warning: Removed 82 rows containing non-finite values (stat_density).
```

![](README-fatalities%20plot%20by%20age-1.png)<!-- -->
