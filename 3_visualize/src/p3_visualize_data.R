source("3_visualize/src/plot_timeseries.R")

tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr


# plot data
p3_targets_list <- list(
  tar_target(
    p3_figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", p2_site_data_styled),
    format = "file"
  )
)