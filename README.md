
<!-- README.md is generated from README.Rmd. Please edit that file -->
ozroaddeaths [![Travis-CI Build Status](https://travis-ci.org/ropenscilabs/ozroaddeaths.svg?branch=master)](https://travis-ci.org/ropenscilabs/ozroaddeaths) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropenscilabs/ozroaddeaths?branch=master&svg=true)](https://ci.appveyor.com/project/ropenscilabs/ozroaddeaths)
=======================================================================================================================================================================================================================================================================================================================================================

ozroaddeaths is a package that pulls data from the Australian Road Deaths Database, run by the Bureau of Infrastructure, Transport and Regional Economics (BITRE). This provides basic details of road transport crash fatalities in Australia as reported by the police each month to the State and Territory road safety authorities. The details provided in the database fall into two groups:

1.  The circumstances of the crash, for example, date, location, crash type

2.  Some details regarding the persons killed, for example, age, gender and road user group.

Installation
------------

You can install ozroaddeaths from github with:

``` r
# install.packages("devtools")
devtools::install_github("ropenscilabs/ozroaddeaths")
```

This data is taken from the Australian Road Deaths Database, which provides basic details of road transport crash fatalities in Australia as reported by the police each month to the State and Territory road safety authorities, obtained from: <https://bitre.gov.au/statistics/safety/fatal_road_crash_database.aspx>

Details provided in the database fall into two groups:

-   the circumstances of the crash, for example, date, location, crash type

-   some details regarding the persons killed, for example, age, gender and road user group.

The fatality data is updated every month. The heavy vehicle flags (for articulated truck, heavy rigid truck and bus involvement) are only updated each quarter, and are current to within two months. Information for heavy rigid truck involvement in crashes earlier than 2004 is incomplete.

Package Author's Notes
----------------------

Data was available at URL as at 17/10/26. Data is imported into R and cleaned by removing redundant date columns and transforming into a tidy format.

### Indemnity Statement:

The Bureau of Infrastructure, Transport and Regional Economics has taken due care in preparing this information. However, noting that data have been provided by third parties, the Commonwealth gives no warranty as to the accuracy, reliability, fitness for purpose, or otherwise of the information.

Copyright

© Commonwealth of Australia, 2017

This work is copyright and the data contained in this publication should not be reproduced or used in any form without acknowledgement.

Import data from the BITRE website into R
-----------------------------------------

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

Variables available
-------------------

### Crashes

``` r
knitr::kable(dplyr::as_data_frame(names(crashes)))
```

| value               |
|:--------------------|
| crash\_id           |
| state               |
| date                |
| month               |
| year                |
| weekday             |
| time                |
| crash\_type         |
| n\_fatalities       |
| bus                 |
| heavy\_rigid\_truck |
| articulated\_truck  |
| speed\_limit        |
| date\_time          |

``` r
knitr::kable(head(crashes))
```

|     crash\_id| state | date       |  month|  year| weekday | time     | crash\_type      |  n\_fatalities| bus | heavy\_rigid\_truck | articulated\_truck |  speed\_limit| date\_time          |
|-------------:|:------|:-----------|------:|-----:|:--------|:---------|:-----------------|--------------:|:----|:--------------------|:-------------------|-------------:|:--------------------|
|  3.201701e+12| QLD   | 2017-01-01 |      1|  2017| Sunday  | 00:00:00 | Pedestrian       |              1| No  | No                  | No                 |            50| 2016-12-31 13:00:00 |
|  5.201701e+12| WA    | 2017-01-01 |      1|  2017| Sunday  | 16:30:00 | Multiple vehicle |              1| No  | No                  | No                 |           100| 2016-12-31 13:00:00 |
|  5.201701e+12| WA    | 2017-01-01 |      1|  2017| Sunday  | 17:14:00 | Multiple vehicle |              1| No  | No                  | No                 |            70| 2016-12-31 13:00:00 |
|  1.201701e+12| NSW   | 2017-01-02 |      1|  2017| Monday  | 18:10:00 | Single vehicle   |              1| No  | No                  | No                 |            50| 2017-01-01 13:00:00 |
|  1.201701e+12| NSW   | 2017-01-02 |      1|  2017| Monday  | 13:15:00 | Multiple vehicle |              1| No  | No                  | No                 |            80| 2017-01-01 13:00:00 |
|  3.201701e+12| QLD   | 2017-01-02 |      1|  2017| Monday  | 03:00:00 | Pedestrian       |              1| No  | No                  | No                 |           100| 2017-01-01 13:00:00 |

### Fatalities

``` r
knitr::kable(dplyr::as_data_frame(names(fatalities)))
```

| value               |
|:--------------------|
| crash\_id           |
| date\_time          |
| month               |
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

``` r
knitr::kable(head(fatalities))
```

|     crash\_id| date\_time          | month   | weekday | time  | state | crash\_type | bus | heavy\_rigid\_truck | articulated\_truck |  speed\_limit| road\_user       | gender |  age|
|-------------:|:--------------------|:--------|:--------|:------|:------|:------------|:----|:--------------------|:-------------------|-------------:|:-----------------|:-------|----:|
|  3.201701e+12| 2017-01-01 00:00:00 | January | Sunday  | 00:00 | QLD   | Pedestrian  | No  | No                  | No                 |            50| Pedestrian       | Female |   64|
|  5.201701e+12| 2017-01-01 16:30:00 | January | Sunday  | 16:30 | WA    | Multiple    | No  | No                  | No                 |           100| Motorcycle rider | Male   |   21|
|  5.201701e+12| 2017-01-01 17:14:00 | January | Sunday  | 17:14 | WA    | Multiple    | No  | No                  | No                 |            70| Driver           | Male   |   25|
|  3.201701e+12| 2017-01-02 03:00:00 | January | Monday  | 03:00 | QLD   | Pedestrian  | No  | No                  | No                 |           100| Pedestrian       | Female |   30|
|  1.201701e+12| 2017-01-02 13:15:00 | January | Monday  | 13:15 | NSW   | Multiple    | No  | No                  | No                 |            80| Motorcycle rider | Male   |   26|
|  1.201701e+12| 2017-01-02 18:10:00 | January | Monday  | 18:10 | NSW   | Single      | No  | No                  | No                 |            50| Driver           | Male   |   28|

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

![](README-crash%20plot%20by%20year-1.png)

### Plot crashes by year and state

``` r

crash_plot +
  scale_y_continuous(trans = "log2") +
  facet_wrap(~state) +
   ggtitle("Annual number of fatal car accidents per year and state",
           subtitle = "log2 scale" )
```

![](README-crash%20plot%20by%20year%20and%20state-1.png)

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
#> Warning: Removed 40 rows containing non-finite values (stat_count).
```

![](README-fatalities%20plot%20by%20year-1.png)

``` r

fatality_plot <- fatalities %>%
  filter(gender != "Unknown") %>%
  mutate(year = lubridate::year(date_time)) %>%
  ggplot(aes(x = age, 
             fill = gender )) +
  geom_density() +
  facet_wrap(~gender) +
  theme_minimal() +
  ggtitle("Distribution of road fatalities by age 1989 to 2017")

fatality_plot
#> Warning: Removed 78 rows containing non-finite values (stat_density).
```

![](README-fatalities%20plot%20by%20age-1.png)
