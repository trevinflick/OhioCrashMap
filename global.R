library(tidyverse)
library(zipcodeR)

clean_data <- read_csv('data/clean_data.csv')

ohio <- search_state('OH')
ohio_county <- ohio$county %>% unique()
