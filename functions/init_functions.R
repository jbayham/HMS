# Init functions:
# These functions help to initialize the project without
# leaving artifacts in the workspace

#####################################################
#Loading and installing packages
init.pacs <- function(package.list){
  check <- unlist(lapply(package.list, require, character.only = TRUE))
  #Install if not in default library
  if(any(!check)){
    for(pac in package.list[!check]){
      install.packages(pac)
    }
    lapply(package.list, require, character.only = TRUE)
  }
}
#unit test
#init.pacs(c("scales"))


#####################################################
#Run all scripts in a directory
run.script <- function(dir.name){
  #check whether directory exists
  if(dir.exists(dir.name)){
    if(!is.null(dir(dir.name,pattern = ".R"))){
      invisible(lapply(dir(dir.name,pattern = ".R",full.names = T),source))
    }
  } else {
    stop("Invalid directory name")
  }
}
#unit test
#run.script("functions")

####################################################
#Load data from cache or build out from raw data
#note that data is attached into a workspace named after the 
#cache file name
cache.or.build <- function(){
  if(!dir.exists("cache")){
    dir.create("cache")
  }
  
  if(file.exists("cache/dataset.Rdata")){
    message("Loading the cached dataset for analysis.  Delete cache/dataset.Rdata to rebuild dataset from components.")
    load("cache/dataset.Rdata",envir = .GlobalEnv)
  } else {
  
    cache.check <- dir("cache",pattern = ".Rdata")
    munge.list <- dir("munge",pattern = ".R")
    munge.check <- str_c(str_extract(str_extract(munge.list,"(?<=-).+"),".+(?=.R)"),".Rdata")  #double extract statements is probably inefficient
  
    #load the cached data that correspond to munge files
    load.cache <- dplyr::intersect(cache.check,munge.check)
    if(!is.null(load.cache)){
      for(cache in load.cache){
        message(str_c("Loading ",cache," from cache..."))
        load(str_c("cache/",cache),envir = .GlobalEnv)
      }
    }
    
    #run the appropriate munge script if cached data does not exist
    run.munge <- str_extract(dplyr::setdiff(munge.check,cache.check),".+(?=.Rdata)")
    if(!is.null(run.munge)){
      for(munge in run.munge){
        m.temp <- str_subset(munge.list,munge)
        message(str_c("Running ",str_c("munge/",m.temp),"... "))
        source(str_c("munge",m.temp))
      }
    }
  }
}
