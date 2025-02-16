library(tidyverse)
library(Hmisc)
#Importing files
setwd("C://Users/jacob/OneDrive/Documents/travel/Flights")
flights_files = c("WDI.csv","RRDC.csv", "TI.csv","STI.csv","SF.csv", "SD.csv", "SLC.csv", "PHX.csv", 
                    "PHI.csv", "ORL.csv", "NLI.csv", "LGA.csv", "JFK.csv", "NAS.csv",
                    "MIA.csv", "LA.csv", "LV.csv", "ATL.csv", "FrtLd_Holly.csv", "CHI_Hare.csv", "CHI_Midway.csv", 
                    "ATX.csv", "BA_WA.csv", "LI.csv", 
                    "CDI.csv", "DFW.csv","DI.csv", 
                    "DMWC.csv", "GBIH.csv", "MSPI.csv"
                    
)
flight_data = read_csv(flights_files, id = "file", skip = 1) %>%
  mutate(airport_origin = substr(file, 1, nchar(file) - 4),
         Year = as.factor(Year),
  ) %>%
  rename(Domestic_Flights = DOMESTIC,
         International_Flights = INTERNATIONAL,
         Total_Flights = TOTAL)
flight_data
#Note: The dataframe has both monthly values and total values for each year, so I qill seperate them
flight_total = flight_data %>%
  filter(Month == "TOTAL") %>%
  select(!Month)
flight_month = flight_data %>%
  filter(Month != "TOTAL") %>%
  mutate(Month = as.factor(Month))
flight_month