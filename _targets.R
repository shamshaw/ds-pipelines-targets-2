library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/process_and_style.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr
nwis_sites = c("01427207", "01432160", "01435000", "01436690", "01466500")

# Download NWIS data and site info
p1_targets_list <- list(
  tar_target(
    site_data_01427207,
    download_nwis_data(nwis_sites[1],'1_fetch/out/nwis_data/'),
  ),
  tar_target(
    site_data_01432160,
    download_nwis_data(nwis_sites[2],'1_fetch/out/nwis_data/'),
  ),
  tar_target(
    site_data_01435000,
    download_nwis_data(nwis_sites[3],'1_fetch/out/nwis_data/'),
  ),
  tar_target(
    site_data_01436690,
    download_nwis_data(nwis_sites[4],'1_fetch/out/nwis_data/'),
  ),
  tar_target(
    site_data_01466500,
    download_nwis_data(nwis_sites[5],'1_fetch/out/nwis_data/'),
  ),
  tar_target(in_dir,'1_fetch/out/nwis_data',format ="file"),
  tar_target(
    combined_nwis_data,
    combine_data(in_dir),
  ),
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = "1_fetch/out/site_info.csv", nwis_sites),
    format = "file"
  )
)

# process and style data to prepare for plotting
p2_targets_list <- list(
  tar_target(
    site_data_styled, 
    process_data(combined_nwis_data, site_info_csv)
  )
)

# plot data
p3_targets_list <- list(
  tar_target(
    figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", site_data_styled,
                         ),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
