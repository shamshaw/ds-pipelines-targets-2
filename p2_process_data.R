source("2_process/src/process_and_style.R")

# process and style data to prepare for plotting
p2_targets_list <- list(
  tar_target(
    p2_site_data_styled, 
    process_data(p1_combined_nwis_data_csv, p1_site_info)
  )
)