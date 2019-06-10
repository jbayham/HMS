#This 

#Function to check whether the downloaded data is missing dates
missing.dates <- function(dir.location="cache/shps/"){
  require(rnoaa)
  #extract dates from file names in directory with shp files
  has.days <- dir(dir.location,pattern = ".dbf") %>%
    str_extract(pattern = "[:digit:]+") %>%
    as_date() %>% 
    enframe(name=NULL)
  
  #Create vector of all dates in the range
  full.days <- seq(min(has.days$value),max(has.days$value), by="days") %>% enframe(name=NULL)
  
  #plot missing
  plot <- rnoaa::vis_miss(left_join(full.days,has.days %>% add_column(miss=1)) %>% arrange(value))
  
  #Return vector of dates
  return(list(plot,anti_join(full.days,has.days)))
}

#unit test
test <- missing.dates()
