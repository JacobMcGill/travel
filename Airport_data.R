library(tidyverse)
library(Hmisc)
#Importing files
setwd("C://Users/jacob/OneDrive/Documents/travel/Airport_Origin")
airport_files = c("WDI.csv","RRDC.csv", "TI.csv","STI.csv","SF.csv", "SD.csv", "SLC.csv", "PHX.csv", 
                  "PHI.csv", "ORL.csv", "NLI.csv", "LGA.csv", "JFK.csv", "NAS.csv",
                  "MIA.csv", "LA.csv", "LV.csv", "ATL.csv", "FrtLd_Holly.csv", "CHI_Hare.csv", "CHI_Midway.csv", 
                  "ATX.csv")
airport_data = read_csv(airport_files, id = "file", skip = 1) %>%
  mutate(airport_origin = substr(file, 1, nchar(file) - 4),
         Year = as.factor(Year))
airport_data
#Note: The dataframe has both monthly values and total values for each year, so I qill seperate them
airport_total = airport_data %>%
  filter(Month == "TOTAL") %>%
  select(!Month)
airport_month = airport_data %>%
  filter(Month != "TOTAL") %>%
  mutate(Month = as.factor(Month))
airport_month





airports = data.frame(Year = character(),
                      Month = character(),
                      DOMESTIC = numeric(),
                      INTERNATIONAL = numeric(),
                      TOTAL = numeric(),
                      airport = character())
WDI <- read_csv("C:/Users/jacob/Downloads/Airport_Origin/WDI.csv", skip = 1) %>%
  mutate(airport = "WDI")
WDI = WDI %>%
  mutate(airport = "WDI")
airports = rbind(airports, read_csv("C:/Users/jacob/Downloads/Airport_Origin/WDI.csv", skip = 1) %>%
                   mutate(airport = "WDI"))
file = "C:/Users/jacob/Downloads/Airport_Origin/"

folder_reader = function(file_names, file_path) {
  #psuedocode: need to take each name in filenames the extract the csvs, save it 
  #as a dataframe, then add it to the airport dataframes
  airports = data.frame(Year = character(),
                        Month = character(),
                        DOMESTIC = numeric(),
                        INTERNATIONAL = numeric(),
                        TOTAL = numeric(),
                        airport = character())
  for (i in file_names)
    airports = rbind(airports, read_csv(paste0(file_path, i, ".csv" ), skip = 1) %>%
                       mutate(airport = i))
  return(airports)
}
folder_reader <- function(file_names, file_path) {
  # Initialize a list to store data frames
  airport_list <- vector("list", length(file_names))
  
  # Iterate through file names and read CSVs
  for (i in seq_along(file_names)) {
    file_name <- file_names[i]
    select_file <- file.path(file_path, paste0(file_name, ".csv"))
   
    # Read CSV and add airport column
    airport_data <- read_csv(select_file, skip = 1, col_types = cols(.default = "c")) %>%
      mutate(airport = file_name)
    
    # Store in the list
    airport_list[[i]] <- airport_data
  }
  
  # Combine all data frames into one
  airports <- bind_rows(airport_list)
  return(airports)
}
txt_list = list("WDI", "RRDC")
test = folder_reader(txt_list, file) 
