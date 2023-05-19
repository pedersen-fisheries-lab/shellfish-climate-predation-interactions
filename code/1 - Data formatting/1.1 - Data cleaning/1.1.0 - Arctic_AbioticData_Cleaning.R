### FORMATING ARCTIC ABIOTIC DATA ----
# Purpose: Format Arctic abiotic data to match template
# Author: S. Zabihi-Seissan

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
                                                            ### Packages ----
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

library(data.table)
library(googledrive)

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
                                                    ### Download Data from GDrive ----
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

# Get authorization to access google drive. Browser will prompt you to sign in and copy paste code into console.
#drive_auth() #uncomment and run this line if you want to clear authorization

# Download data into working directory 
drive_download(as_id("1_YDhUiORdkMkXdXODahinveBdEOTMkWE"),path="data/temp/ARC_Abiotic_Data.csv",overwrite=TRUE)

# Load data
Data<-fread('data/temp/ARC_Abiotic_Data.csv')

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
                                                          ### Processing ----
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

# Change column names
Data$region<-"Arctic"

# Calculate tow_area from tow_length
colnames(Data)[colnames(Data)=="tow_length (km)"] <- "tow_length"
Data$tow_area<-(0.01838*Data$tow_length)
Data$tow_length<-NULL

# Re-order columsn to match template
setcolorder(Data, c("region", "year_surv","year","month","day","strata","strata_area","set","trip","vessel",
                    "nafo","latitude","longitude","depth","temperature_at_bottom","tow_area","salinity","oxygen"))

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
                                                  ### Save output to GDrive ----
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

fwrite(Data, "data/abiotic/Arctic_Abiotic_Data_Cleaned.csv")

# Remove unnecessary temporary files
file.remove("data/temp/ARC_Abiotic_Data.csv")
