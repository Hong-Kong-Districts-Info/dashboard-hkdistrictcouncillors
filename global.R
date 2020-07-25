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
library(sf)

library(ggplot2)

## shiny-related
library(shiny)
library(shinyBS)
library(shinydashboard)
library(DT)

# put gsheets into de-authorised state so no need for personal token for app
gs4_deauth()

# Data file paths ---------------------------------------------------------
sheet_url <- "https://docs.google.com/spreadsheets/d/1007RLMHSukSJ5OfCcDJdnJW5QMZyS2P-81fe7utCZwk/"
path_shape_district <- "data/dcca_2019/DCCA_2019.shp"
path_shape_hk <- "data/gadm/gadm36_HKG_0.shp"


# Data import -------------------------------------------------------------

## gsheets
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

<<<<<<< HEAD
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
||||||| constructed merge base
# map
shape_district <- readOGR(dsn = path_shape)
## convert to dataframe
shape_district <- fortify(model = shape_district)

## prepare for chloropleth
centroids <- setNames(object = do.call(what = "rbind.data.frame",
                                      args = by(shape_district, shape_district$group, function(x) {Polygon(x[c('long', 'lat')])@labpt})),
                      c('long', 'lat'))
centroids$label <- shape_district$id[match(rownames(centroids), shape_district$group)]
  
=======
## shapefiles
shape_district <- st_read(dsn = path_shape_district)
shape_hk <- st_read(dsn = path_shape_hk)

# Pre-load/create map
map_hk_districts <- 
>>>>>>> feat: Load in HK and district shapes
