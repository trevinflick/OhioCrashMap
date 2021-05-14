library(tidyverse)
library(data.table)
library(lubridate)

crash <- fread("data/CrashStatistics.csv") %>%
  separate(CrashDateTime, c("CrashDate", "Time", "AM"), sep = "\\s") %>%
  mutate(CrashTime = paste(Time, AM),
         CrashDate = as.Date(CrashDate, format =  "%m/%d/%Y"),
         CrashYear = year(CrashDate),
         CrashMonth = month(CrashDate),
         CrashDay = day(CrashDate))

ped_bike <- crash %>%
  filter(CrashSeverity == 'Fatal',
         PedestrianRelated == TRUE | BicycleRelated == TRUE,
         Latitude < 50)

clean_data <- ped_bike %>%
  select(
    CrashDate,
    CrashYear,
    CrashMonth,
    CrashDay,
    CrashTime,
    LightCondition,
    Weather,
    County,
    CityVillageTownshipName,
    Lat = Latitude,
    Long = Longitude,
    PedestrianRelated,
    BicycleRelated,
    Narrative
  ) %>% arrange(CrashDate)

write.csv(clean_data, 'clean_data.csv', row.names = FALSE)
