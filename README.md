# NOAA HMS Smoke


This repo contained a set of scripts I used to download and process smoke plume data from NOAA Hazard Mapping System.  I intially wrote the scripts in March 2018.  In June of 2019, the ftp site that used to store the smoke plume data has been moved.  I've cached the plume data from August 2005 to 2017 and can be downloaded from https://drive.google.com/open?id=1kgxGHYoRcdpdxXE5O9pQxnJqBkNKJGQy.  A brief gist to download the data is here: https://gist.github.com/jbayham/f54604c02adf0ea27ff1706e2f51a7e4

The Process_Smoke.R script reads the shape files into sf objects and puts them all in a list with an associated date.  

Todo: 

- put the list containing the sf polygons in a more usable format
