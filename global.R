# -------- #
# global.R #
# -------- #

# DESC: global.R script used to create static objects that app needs to run.
#       Includes importing packages, loading and manipulating data.


# Packages ----------------------------------------------------------------

## datawrangling
library(dplyr)
library(data.table)
library(dtplyr)
library(tidyr)

## shiny-related
library(shiny)
library(shinydashboard)
library(DT)

# dummy data 
data_region <- c("Hong Kong Island", 
                 "Kowloon",
                 "New Territories")