# Functions for downloading NWIS site data and info

# -----------------------

# load all files in download directory and combine into a dataframe
combine_data <- function(out_file_path, list_of_dataframes) {
  
  # combined data
  data_out <- bind_rows(list_of_dataframes, .id = "column_label")
  
  write_csv(data_out, out_file_path)
  
  return(out_file_path)
}

# ----------------------

# Download site information for provided NWIS site numbers
nwis_site_info <- function(in_file_path){
  
  site_data <-read_csv(in_file_path, col_types = 'cccTddcdd')
  
  site_no <- unique(site_data$site_no)
  site_info <- dataRetrieval::readNWISsite(site_no)
  return(site_info)
}

# -------------------------

download_nwis_site_data <- function(site_num, 
                                    parameterCd = '00010', 
                                    startDate="2014-05-01", 
                                    endDate="2015-05-01"){
  
  # readNWISdata is from the dataRetrieval package
  data_out <- readNWISdata(sites=site_num, service="iv", 
                           parameterCd = parameterCd, startDate = startDate, endDate = endDate)

  # -- simulating a failure-prone web-sevice here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  # -- end of do-not-edit block
  
  return(data_out)
}

