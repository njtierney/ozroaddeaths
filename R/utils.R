classes <- function(x){
  purrr::map(x, class)
}
