library(targets)

source('1_fetch/src/p1_download_data.R')
source('2_process/src/p2_process_data.R')
source('3_visualize/src/p3_visualize_data.R')

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
