#Script to download all smoke shp files


for(i in 2007:2011){ #2005:2017
  base.url <- str_c("ftp://satepsanone.nesdis.noaa.gov/volcano/FIRE/HMS_ARCHIVE/",i,"/GIS/SMOKE/")
  file.names <- getURL(base.url, 
                      ftp.use.epsv = FALSE, 
                      dirlistonly = TRUE) %>%
    str_split_fixed(pattern = regex("\\r\\n"),n=Inf)  
  if(i>=2012){
    file.names <- str_subset(file.names,".zip.gz") #".zip(?!.)" --> not followed by .gz
  } else {
    file.names <- str_subset(file.names,".gz")
  }

  pb <- progress_bar$new(
    format = " [:bar] :percent eta: :eta",
    total = length(file.names), clear = FALSE, width= 60)
  
  for(j in file.names){
    pb$tick()
    if(i>=2012){
      download.file(str_c(base.url,j), destfile = str_c("zipped_gis/",j),quiet = T)
    } else {
      download.file(str_c(base.url,j), destfile = str_c("zipped_pre2012/",j),quiet = T)
    }
  }
}

############################################################
message("Stop and manually extract the nested zipped files and put the shp files in a directory called shps")


#############################################################
#Renaming shp files in a consistent manner
name.list <- dir("cache/shps")
map(str_subset(name.list,"smokepolygons"),
    function(x){
      file.rename(str_c("cache/shps/",x),
                  str_c("cache/shps/",str_replace(x,"smokepolygons.","hms_smoke")))
    } )

