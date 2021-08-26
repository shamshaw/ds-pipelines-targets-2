library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/process_and_style.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

# Download NWIS data and site info
p1_targets_list <- list(
  tar_target(
    site_data_01427207,
    download_nwis_site_data(site_num = '01427207')
  ),
  tar_target(
    site_data_01432160,
    download_nwis_site_data(site_num = '01432160')
  ),
  tar_target(
    site_data_01435000,
    download_nwis_site_data(site_num = '01435000')
  ),
  tar_target(
    site_data_01436690,
    download_nwis_site_data(site_num = '01436690')
  ),
  tar_target(
    site_data_01466500,
    download_nwis_site_data(site_num = '01466500')
  ),
  tar_target(
    combined_nwis_data_csv,
    combine_data(out_file_path = "2_process/out/combined_nwis_data.csv", list(site_data_01427207, site_data_01432160, site_data_01435000, site_data_01436690, site_data_01466500)),
    format = "file"
  ),
  tar_target(
    site_info,
    nwis_site_info(combined_nwis_data_csv)
   )
)

# process and style data to prepare for plotting
p2_targets_list <- list(
  tar_target(
    site_data_styled, 
    process_data(combined_nwis_data_csv, site_info)
  )
)

# plot data
p3_targets_list <- list(
  tar_target(
    figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", site_data_styled),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
