process_data <- function(nwis_data_path, site_info){
  nwis_data <- read_csv(nwis_data_path, col_types = 'cccTddcdd')
  nwis_data_clean <- rename(nwis_data, water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, -tz_cd)
  browser()
  
  site_data_styled <- left_join(nwis_data_clean, site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, water_temperature, latitude = dec_lat_va, longitude = dec_long_va) %>%
    mutate(station_name = as.factor(station_name))
 
  return(site_data_styled)
}
