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

library(leaflet)

## shiny-related
library(shiny)
library(shinyBS)
library(shinydashboard)
library(DT)

library(rintrojs)

## put gsheets into de-authorised state so no need for personal token for app
gs4_deauth()

# Data file paths ---------------------------------------------------------
sheet_url <- "https://docs.google.com/spreadsheets/d/1007RLMHSukSJ5OfCcDJdnJW5QMZyS2P-81fe7utCZwk/"
path_data <- "extdata"
path_shape_district <- paste0(path_data, "/" , "dcca_2019/DCCA_2019.shp")


# Data import -------------------------------------------------------------

## shapefiles
shape_district <- st_read(dsn = path_shape_district)
shape_district <- st_transform(x = shape_district, crs = 4326)
shape_district$centroids <- shape_district %>% 
  st_centroid() %>% 
  st_coordinates()

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
map_hk_districts <- leaflet(data = st_as_sf(data_master_raw)) %>% 
  addTiles() %>% 
  addPolygons(weight = 0.5, 
              fillOpacity = 0.3, 
              color = '#009E73',
              highlightOptions = highlightOptions(color = '#000000', 
                                                  weight = 2,
                                                  bringToFront = TRUE),
              popup = data_master_raw$DropDownText,
              options = popupOptions(clickable = TRUE, closeOnClick = TRUE))


# Typeform HTML -----------------------------------------------------------
html_typeform <- HTML(text = "<div class=\"typeform-widget\" 
                              data-url=\"https://form.typeform.com/to/gFHC02gE\" 
                              style=\"width: 100%; height: 800px;\"></div> 
                              <script> (function() { var qs,
                                                    js,
                                                    q,
                                                    s,
                                                    d=document, 
                                                    gi=d.getElementById, 
                                                    ce=d.createElement, 
                                                    gt=d.getElementsByTagName, 
                                                    id=\"typef_orm\", 
                                                    b=\"https://embed.typeform.com/\"; 
                                                      if(!gi.call(d,id)) { js=ce.call(d,\"script\"); 
                                                      js.id=id; js.src=b+\"embed.js\"; 
                                                      q=gt.call(d,\"script\")[0]; 
                                                      q.parentNode.insertBefore(js,q) } }
                                        )() </script> 
                              <div style=\"font-family:Sans-Serif;
                                            font-size:12px;
                                            color: #999;
                                            opacity: 0.5; 
                                            padding-top: 5px;
                                          \"> powered by 
                                          <a href=\"https://admin.typeform.com/signup?utm_campaign=gFHC02gE&utm_source=typeform.com-01EENYCBWQACS4BQ2SV4V5D2C9-free&utm_medium=typeform&utm_content=typeform-embedded-poweredbytypeform&utm_term=EN\" 
                                                  style=\"color: #999\" 
                                                  target=\"_blank\">Typeform</a> </div>")

