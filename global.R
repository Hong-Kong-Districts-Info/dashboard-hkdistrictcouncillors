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

# set theme for plots
plot_theme <- theme(plot.title = element_text(face = "bold", hjust = 0.5),
                    plot.subtitle = element_text(face = "bold", hjust = 0.5),
                    panel.background = element_blank(),
                    axis.line = element_blank(),
                    axis.text = element_blank(),
                    axis.ticks = element_blank())

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


data_master <- data_master_raw %>% 
  mutate(ConstituencyCode = gsub(x = ConstituencyCode, pattern = "-", replacement = "")) %>% 
  left_join(y = shape_district, by = c("ConstituencyCode" = "CACODE"))

# Pre-load/create map
<<<<<<< HEAD
map_hk_districts <- 
>>>>>>> feat: Load in HK and district shapes
||||||| constructed merge base
map_hk_districts <- 
=======
map_hk_districts <- ggplot() +
  geom_sf(data = shape_hk, fill = '#009E73') +
  geom_sf(data = shape_district, fill = '#56B4E9', alpha = 0.2, linetype = 'dotted', size = 0.2) +
  plot_theme
>>>>>>> feat: Make lines thinner
