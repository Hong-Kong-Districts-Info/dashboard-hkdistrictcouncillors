# -------- #
# global.R #
# -------- #

# DESC: global.R script used to create static objects that app needs to run.
#       Includes importing packages, loading and manipulating data.


# Packages ----------------------------------------------------------------

## data wrangling
library(dplyr)
library(tidyr)
library(sf)
library(hkdatasets)

library(leaflet)

## shiny-related
library(shiny)
library(shinyBS)
library(shinyjs)
library(shinydashboard)
library(DT)

library(rintrojs)
library(shinyhelper)
library(shinycssloaders)

# set spinner options
options(spinner.color = "#009E73",
        spinner.type = 8)


# Data file paths ---------------------------------------------------------

path_data <- "extdata"
path_shape_district <- paste0(path_data, "/" , "dcca_2019/DCCA_2019.shp")


# Data import -------------------------------------------------------------

## shapefiles
shape_district <- st_read(dsn = path_shape_district)
shape_district <- st_transform(x = shape_district, crs = 4326)
shape_district$centroids <- shape_district %>% 
  st_centroid() %>% 
  st_coordinates()

# add iframe to master sheet ----------------------------------------------
chunk1 <- '<div class="container2"><iframe class="responsive-iframe" src="https://www.facebook.com/plugins/page.php?href='
chunk3 <- '&tabs=timeline&width=400&height=800&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=3131730406906292" width="400" height="800" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe></div>'


## Take data from HK data sets
data_master_raw <-
  hkdatasets::hkdc %>%
  # link to individual DC page
  mutate(ind_page = paste0("https://hong-kong-districts-info.github.io/dc/",
                           tolower(ConstituencyCode))) %>%
  # infoBox colour indicating if FB link exists
  mutate(exists_web = if_else(condition = !is.na(x = ind_page), "blue", "black"),
         # remove hyphen for joining to shape file
         ConstituencyCode = gsub(x = ConstituencyCode, pattern = "-", replacement = "")) %>%
  left_join(y = shape_district, by = c("ConstituencyCode" = "CACODE")) %>%
  
  # Create bilingual categories to show on app and iframe link
  mutate(Region = paste(Region_ZH, "/", Region_EN),
         District = paste(District_ZH, "/", District_EN),
         DropDownText = paste0(ConstituencyCode, ": ", Constituency_ZH, " / ", Constituency_EN),
         Party = paste(Party_ZH, "/", Party_EN),
         DC = paste(DC_ZH, "/", DC_EN),
         iframe = paste0(chunk1, FacebookURL, chunk3))
  
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
