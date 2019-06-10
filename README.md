# HMS


This repo contained a set of scripts I used to download and process smoke plume data from NOAA Hazard Mapping System.  I intially wrote the scripts in March 2018.  In June of 2019, the ftp site that used to store the smoke plume data has been moved.  I've cached the plume data from August 2005 to 2017 and can be downloaded from https://drive.google.com/drive/folders/1ayibI1WBkou-Hvva4pxSwZ7wqhykmHKx?usp=sharing.  

The Process_Smoke.R script reads the shape files into sf objects and puts them all in a list with an associated date.  

Todo: 

- put the list in a more usable format
