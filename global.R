# -------- #
# global.R #
# -------- #

# DESC: global.R script used to create static objects that app needs to run.
#       Includes importing packages, loading and manipulating data.


# Packages ----------------------------------------------------------------

## datawrangling
library(dplyr)
library(tidyr)
library(googlesheets4)

## shiny-related
library(shiny)
library(shinyBS)
library(shinydashboard)
library(DT)


## Read data from Google Sheets 4
sheet_url <- "https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/"

# put gsheets into de-authorised state
# so no need to provide personal token
gs4_deauth()

data_master_raw <-
  googlesheets4::read_sheet(ss = sheet_url,
                            sheet = "Master",
                            na = c("N/A", "")) %>% 
  # infoBox colour indicating if FB link exists
  mutate(exists_fb = if_else(condition = !is.na(x = facebook), "blue", "black"))