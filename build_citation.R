get_yaml_header <-
  function(file,
           yaml_rxp = "^\\#*---[[:space:]]*$",
           verbose = TRUE) {
    # read first line to check for header
    con <- file(file, "r")
    on.exit(close(con))
    first_line <- readLines(con, n = 1L)
    
    # if header, read it in until "---" found
    iline <- 1L
    closing_tag <- FALSE
    out <- character()
    while (!isTRUE(closing_tag)) {
      out[iline] <- readLines(con, n = 1L)
      if (grepl(yaml_rxp, out[iline])) {
        closing_tag <- TRUE
      } else {
        iline <- iline + 1L
      }
    }
    
    out %>%
      dplyr::as_data_frame() %>%
      dplyr::filter(value != "---") %>%
      tidyr::separate(value, into = c("yaml", "value"), sep = ":") %>%
      dplyr::mutate(value = stringr::str_trim(value))
  }
get_yaml_header("resources_econ.Rmd")
