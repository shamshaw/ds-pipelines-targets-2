source("1_fetch/src/get_nwis_data.R")

tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

# Download NWIS data and site info
p1_targets_list <- list(
  tar_target(
    p1_site_data_01427207,
    download_nwis_site_data(site_num = '01427207')
  ),
  tar_target(
    p1_site_data_01432160,
    download_nwis_site_data(site_num = '01432160')
  ),
  tar_target(
    p1_site_data_01435000,
    download_nwis_site_data(site_num = '01435000')
  ),
  tar_target(
    p1_site_data_01436690,
    download_nwis_site_data(site_num = '01436690')
  ),
  tar_target(
    p1_site_data_01466500,
    download_nwis_site_data(site_num = '01466500')
  ),
  tar_target(
    p1_combined_nwis_data_csv,
    combine_data(out_file_path = "1_fetch/out/combined_nwis_data.csv", list(p1_site_data_01427207, p1_site_data_01432160, p1_site_data_01435000, p1_site_data_01436690, p1_site_data_01466500)),
    format = "file"
  ),
  tar_target(
    p1_site_info,
    nwis_site_info(p1_combined_nwis_data_csv)
  )
)