#This script sets up the project
#It should be run once each time a user begins a new R session to work on the project.

#########################
#Load init functions
source("functions/init_functions.R")

#Loading and installing packages
init.pacs(c("RCurl",           #Web utilities
              "rvest",         #tidy webscraping
              "tidyverse",     #
              "lubridate",     #to work with dates
              "sf",            #tidy compatible GIS
              "progress"       #for progress bar
              ))


#Setting package::function priority with conflicted package
conflict_prefer("filter", "dplyr")
conflict_prefer("between", "dplyr")

#########################
#Loading project helper functions (all scripts within folder)
run.script("functions")

#Create directory to store downloaded files
if(!dir.exists("cache")){
  dir.create("cache")
  message("A cache folder has been created. Downloaded data will be put in that folder.")
}

#######################
#Setting readin projections for GIS
readin.proj=4269 #because it works with the lat and lons provided

#Project flow:
#Download shp files
#run process smoke to bind daily shapes into a list