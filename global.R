# -------- #
# global.R #
# -------- #

# DESC: global.R script used to create static objects that app needs to run.
#       Includes importing packages, loading and manipulating data.


# Packages ----------------------------------------------------------------

## data wrangling
library(dplyr)
library(tidyr)
library(googlesheets4)
library(rgdal)

library(ggplot2)

## shiny-related
library(shiny)
library(shinyBS)
library(shinydashboard)
library(DT)


## data source
sheet_url <- "https://docs.google.com/spreadsheets/d/1007RLMHSukSJ5OfCcDJdnJW5QMZyS2P-81fe7utCZwk/"
path_shape <- "data/DCCA_2019.shp"

# put gsheets into de-authorised state
# so no need to provide personal token
gs4_deauth()

data_master_raw <-
  googlesheets4::read_sheet(ss = sheet_url,
                            sheet = "Master",
                            na = c("N/A", "")) %>% 
  # infoBox colour indicating if FB link exists
<<<<<<< HEAD
  mutate(exists_fb = if_else(condition = !is.na(x = facebook), "blue", "black"))
||||||| constructed merge base
  mutate(exists_fb = if_else(condition = !is.na(x = facebook), "blue", "black"))

# Version to be shown with DT on app
data_master_details <-
  googlesheets4::read_sheet(ss = sheet_url,
                            sheet = "Master",
                            na = c("N/A", "")) %>%
  select(Constituency = "DropDownText",
         Party,
         DC,
         Region,
         District,
         FB = "facebook")
  
=======
  mutate(exists_fb = if_else(condition = !is.na(x = facebook), "blue", "black"))

# Version to be shown with DT on app
data_master_details <-
  googlesheets4::read_sheet(ss = sheet_url,
                            sheet = "Master",
                            na = c("N/A", "")) %>%
  select(Constituency = "DropDownText",
         Party,
         DC,
         Region,
         District,
         FB = "facebook")

# map
shape_district <- readOGR(dsn = path_shape)
## convert to dataframe
shape_district <- fortify(model = shape_district)

## prepare for chloropleth
centroids <- setNames(object = do.call(what = "rbind.data.frame",
                                      args = by(shape_district, shape_district$group, function(x) {Polygon(x[c('long', 'lat')])@labpt})),
                      c('long', 'lat'))
centroids$label <- shape_district$id[match(rownames(centroids), shape_district$group)]
  
>>>>>>> feat: Import shapesfile of districts
