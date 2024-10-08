cli_alert_success <- function(text, .envir = parent.frame()) {
  if (!getOption("emodnet.wfs.quiet", FALSE)) {
    cli::cli_alert_success(text, .envir = .envir)
  }
}

cli_alert_info <- function(text, .envir = parent.frame()) {
  if (!getOption("emodnet.wfs.quiet", FALSE)) {
    cli::cli_alert_info(text, .envir = .envir)
  }
}

cli_alert_danger <- function(text, .envir = parent.frame()) {
  if (!getOption("emodnet.wfs.quiet", FALSE)) {
    cli::cli_alert_danger(text, .envir = .envir)
  }
}
