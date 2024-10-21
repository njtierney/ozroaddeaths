#' Get BITRE data with hard coded link
#' @param group Character. The group name.
#' @return path to the temporary XLSX file.
get_bitre_hard_coded <- function(group = "fatal_crashes") {
  stopifnot(group %in% c("fatal_crashes", "fatalities"))

  # Date format: "sep2024"
  # If current date is 2024-10, this will produce
  # "oct2024", "sep2024", ..., "jan2024", "dec2023", ..., "jan2023"
  current_month_num <- as.integer(format(Sys.time(), "%m"))
  months <- tolower(month.abb[current_month_num:1])
  current_year <- as.integer(format(Sys.time(), "%Y"))
  past_year <- current_year - 1
  date_replacement <- c(paste0(months, current_year),
                        paste0(tolower(rev(month.abb)), past_year))

  # Insert dates into the link template.
  links <- glue::glue("https://www.bitre.gov.au/sites/default/files/documents/bitre_{group}_{date_replacement}.xlsx")

  # Try links one by one until one works.
  temp_xlsx <- tempfile()
  target_link <- NA
  for (link in links) {
    error <- try(suppressWarnings(download.file(link, quiet = TRUE, destfile = temp_xlsx)),
                 silent = TRUE)
    if (!inherits(error, "try-error")) {
      target_link <- link
      break
    }
  }

  # If there is no valid link, return an empty string.
  if (is.na(target_link)) {
    return("")
  } else {
    return(temp_xlsx)
  }
}

#' Get BITRE data by scraping the website
#' @param group Character. The group name.
#' @return path to the temporary XLSX file.
get_bitre_scrape <- function(group = "fatal_crashes") {
  stopifnot(group %in% c("fatal_crashes", "fatalities"))

  # Get all links: two XLSX links, one PDF link.
  all_href <- rvest::read_html("https://www.bitre.gov.au/statistics/safety/fatal_road_crash_database") |>
    rvest::html_elements("a.attach") |>
    rvest::html_attr("href")

  # Check if the XLSX link match our group name.
  idx <- which(grepl(glue::glue("{group}.*xlsx"), all_href))[1]
  if (is.na(idx)) return("")

  # Try to use the link to download the XLSX file.
  link <- glue::glue("https://www.bitre.gov.au{all_href[idx]}")
  temp_xlsx <- tempfile()
  error <- try(suppressWarnings(download.file(link, quiet = TRUE, destfile = temp_xlsx)),
               silent = TRUE)

  # Return an empty string when fail.
  if (inherits(error, "try-error")) {
    return("")
  } else {
    return(temp_xlsx)
  }
}

is_empty_path <- function(x) {
  x == ""
}

#' Get BITRE data
#' @param group Character. The group name.
#' @return a tibble.
read_bitre_xlsx_raw <- function(group = "fatal_crashes") {
  stopifnot(group %in% c("fatal_crashes", "fatalities"))

  xlsx_file <- get_bitre_scrape(group = group)
  if (is_empty_path(xlsx_file)) xlsx_file <- get_bitre_hard_coded(group = group)
  if (is_empty_path(xlsx_file)) stop(glue::glue("Can not find a valid URL for {group} data set from BITRE!"))

  readxl::read_xlsx(xlsx_file, sheet = 2, skip = 4)
}
