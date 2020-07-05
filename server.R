# -------- #
# server.R #
# -------- #

# DESC: Code here can be much longer and complicated than in ui.R.
#       Is where all the dynamic data manipulation happens, and plot creations.
#       e.g. Filtering based on user inputs and generating plots based on dynamically filtered data.
#       server.R must create a function called server, like below:

server <- function(input, output, session) {
  
  ## Read data from Google Sheets 4
  # data_master_raw <-
  #   googlesheets4::read_sheet(ss = "https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/",
  #                             sheet = "master")
}