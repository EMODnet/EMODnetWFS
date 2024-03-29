# inspired by janitor::tabyl(),
# to skip the dependency

tabyl <- function(x) {
  df <- tibble::tibble(x = x) %>%
    dplyr::count(x) %>%
    dplyr::mutate(percent = n / sum(n))
  colnames(df) <- c(".", "n", "percent")
  df
}
