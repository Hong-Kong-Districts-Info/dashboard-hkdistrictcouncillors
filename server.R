# -------- #
# server.R #
# -------- #

# DESC: Code here can be much longer and complicated than in ui.R.
#       Is where all the dynamic data manipulation happens, and plot creations.
#       e.g. Filtering based on user inputs and generating plots based on dynamically filtered data.
#       server.R must create a function called server, like below:

server <- function(input, output, session) {

  # ----- REACTIVES ----- #
  
  # filter data according to user selected option
  react_data_constituency <- reactive(
    x = {
      data_select <- filter(.data = data_master_raw, 
                            Constituency_EN == input$input_consituency_en)
      
      return(data_select)
    }
  )
  
  # ----- TAB: Data Explorer ----- #
  

  # ValueBox: Party (English) -----------------------------------------------
  output$valuebox_party_en <- renderValueBox(
    expr = {
      tags$div(
        tipify(
          el = valueBox(value = react_data_constituency(),
                        subtitle = "Affiliated party (English)",
                        icon = icon(name = "box"),
                        color = "maroon"),
          title = "This is the political party that the constituency's DC belongs to", 
          trigger = "hover"
        ) #tipify
      ) #div
    }
  )


  
  
}