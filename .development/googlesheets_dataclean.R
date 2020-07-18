library(tidyverse)
library(googlesheets4)

sheet_url <- "https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/"

# define google sheets ----------------------------------------------------
list_arguments <- list(sheet = c("Central & Western", "Wan Chai", "Eastern", "Southern"))
list_data <- pmap(.l = vec_sheet, .f = read_sheet, ss = sheet_url)
names(list_data) <- paste0("data_master_", c("cnw", "wanchai", "eastern", "southern"))


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
  list_data %>%
  map(clean_gsheet_dat) %>%
  bind_rows()

# Write to sheet ----------------------------------------------------------
googlesheets4::range_write(ss = sheet_url,
                           sheet = "Master",
                           data = master_sheet)
