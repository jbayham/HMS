#Script to readin smoke shapefiles



#############################################################

file.list <- str_subset(dir("cache/shps"),pattern =".shp")
smoke <- vector("list",length(file.list))
pb <- progress_bar$new(
  format = " [:bar] :percent eta: :eta",
  total = length(file.list), clear = FALSE, width= 60)
for(i in 1:length(smoke)){  #
  pb$tick()
  date.temp=ymd(regmatches(file.list[i],regexpr("([0-9]+)",file.list[i])))  
  smoke[[i]] <- st_read(str_c("shps/",file.list[i]),
                        stringsAsFactors = F,
                        quiet = T) %>% 
    st_set_crs(readin.proj) %>% 
    mutate(check=st_is_valid(.), 
           date=date.temp) %>% 
    dplyr::filter(check)
  
  if(max(names(smoke[[i]]) %in% "Density")==0){
    smoke[[i]] <-  add_column(smoke[[i]],Density=NA,.after = "End")
  }
}

#Use this function to generate a date index for the list of sf objects with plumes
date.index <- lapply(smoke,function(x) first(x$date)) %>% unlist() %>% as_date()

save(smoke,date.index,file = "smoke_stack.Rdata")


####################
#plot
usa_map <- us_states(resolution = "low") %>% st_transform(readin.proj) %>% dplyr::filter(!(state_abbr %in% c("AK","HI","PR")))


#US
ggplot() +
  geom_sf(data = smoke[[20]],fill="blue",alpha=.5) +
  geom_sf(data = usa_map,color="red",fill=NA) +
  labs(title="HMS plume over US")
