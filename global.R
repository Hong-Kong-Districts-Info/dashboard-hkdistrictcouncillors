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

## put gsheets into de-authorised state so no need for personal token for app
gs4_deauth()

## set theme for plots
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

## shapefiles
shape_district <- st_read(dsn = path_shape_district)
shape_hk <- st_read(dsn = path_shape_hk)

## gsheets
data_master_raw <-
  googlesheets4::read_sheet(ss = sheet_url,
                            sheet = "Master",
                            na = c("N/A", "")) %>% 
  # infoBox colour indicating if FB link exists
  mutate(exists_fb = if_else(condition = !is.na(x = facebook), "blue", "black"),
         # remove hyphen for joining to shape file
         ConstituencyCode = gsub(x = ConstituencyCode, pattern = "-", replacement = "")) %>% 
  left_join(y = shape_district, by = c("ConstituencyCode" = "CACODE"))


# Map import --------------------------------------------------------------

## Pre-load/create map
map_hk_districts <- ggplot() +
  geom_sf(data = shape_hk, fill = '#009E73') +
  geom_sf(data = shape_district, fill = '#56B4E9', alpha = 0.2, linetype = 'dotted', size = 0.2) +
  plot_theme
