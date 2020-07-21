library(dplyr)
library(purrr)
library(janitor)
library(tidyr)
library(googlesheets4)

sheet_url <- "https://docs.google.com/spreadsheets/d/1007RLMHSukSJ5OfCcDJdnJW5QMZyS2P-81fe7utCZwk/"

# authorise Google account via prompt
gs4_auth()

# define google sheets ----------------------------------------------------
dc_sheet_names <- sheet_names(sheet_url)
dc_sheet_names2 <- dc_sheet_names[!grepl(x = dc_sheet_names, pattern = "^Master$|^DistrictCouncilKey$")]

list_arguments <- list(sheet = dc_sheet_names2)
list_data <- pmap(.l = list_arguments, .f = read_sheet, ss = sheet_url)
names(list_data) <- paste0("data_master_", make_clean_names(dc_sheet_names2))

# Read in DistrictCouncilKey separately
dc_key_sheet <- read_sheet(ss = sheet_url, sheet = "DistrictCouncilKey")

# Clean District Council Key sheet ----------------------------------------

dc_key <-
  dc_key_sheet %>%
  mutate(Region = paste(Region_ZH, "/", Region_EN),
         District = paste(District_ZH, "/", District_EN))

# clean googlesheets ------------------------------------------------------

clean_gsheet_dat <- function(data){
  data %>%
    clean_names() %>%
    separate(col = xuan_qu_constituency, into = c("Constituency_ZH", "Constituency_EN"), sep = "\n", extra = "merge") %>%
    separate(col = dang_pai_party, into = c("Party_ZH", "Party_EN"), sep = "\n", extra = "merge") %>%
    separate(col = qu_yi_yuan_dc, into = c("DC_ZH", "DC_EN"), sep = "\n", extra = "merge") %>%
    rename(ConstituencyCode = "xuan_qu_hao_ma_constituency_code") %>%
    mutate(DropDownText = paste0(ConstituencyCode, ": ", Constituency_ZH, " / ", Constituency_EN),
           Party = paste(Party_ZH, "/", Party_EN),
           DC = paste(DC_ZH, "/", DC_EN))
}


# bind list and assign to master ------------------------------------------

master_sheet <-
  list_data %>%
  map(clean_gsheet_dat) %>%
  bind_rows() %>%
  mutate(Code = substr(ConstituencyCode, start = 1, stop = 1)) %>%
  left_join(dc_key, by = "Code") %>%
  select(-Code)

# Write to sheet ----------------------------------------------------------
googlesheets4::range_write(ss = sheet_url,
                           sheet = "Master",
                           data = master_sheet)
