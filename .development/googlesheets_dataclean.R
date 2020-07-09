library(tidyverse)
library(googlesheets4)

sheet_url <- "https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/"

# define google sheets ----------------------------------------------------
## may consider using purrr once we get to more sheets

data_master_cnw <- googlesheets4::read_sheet(ss = sheet_url, sheet = "Central & Western")
data_master_wanchai <- googlesheets4::read_sheet(ss = sheet_url, sheet = "Wan Chai")
data_master_eastern <- googlesheets4::read_sheet(ss = sheet_url, sheet = "Eastern")
data_master_southern <- googlesheets4::read_sheet(ss = sheet_url, sheet = "Southern")


# clean googlesheets ------------------------------------------------------

clean_gsheet_dat <- function(data){
  data %>%
    janitor::clean_names() %>%
    separate(col = xuan_qu_constituency, into = c("Constituency_ZH", "Constituency_EN"), sep = "\n", extra = "merge") %>%
    separate(col = dang_pai_party, into = c("Party_ZH", "Party_EN"), sep = "\n", extra = "merge") %>%
    separate(col = qu_yi_yuan_dc, into = c("DC_ZH", "DC_ZN"), sep = "\n", extra = "merge") %>%
    rename(ConstituencyCode = "xuan_qu_hao_ma_constituency_code")
}


# bind list and assign to master ------------------------------------------

master_sheet <-
  list(data_master_cnw,
       data_master_wanchai,
       data_master_eastern,
       data_master_southern) %>%
  map(clean_gsheet_dat) %>%
  bind_rows()

# Write to sheet ----------------------------------------------------------
googlesheets4::range_write(ss = sheet_url,
                           sheet = "Master",
                           data = master_sheet)
