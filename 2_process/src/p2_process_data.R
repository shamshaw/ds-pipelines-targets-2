source("2_process/src/process_and_style.R")

tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr


# process and style data to prepare for plotting
p2_targets_list <- list(
  tar_target(
    p2_site_data_styled, 
    process_data(p1_combined_nwis_data_csv, p1_site_info)
  )
)