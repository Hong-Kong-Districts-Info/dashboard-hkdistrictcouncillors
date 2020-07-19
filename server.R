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
                            DropDownText == input$input_dropdowntext)
      
      return(data_select)
    }
  )
  
  # ----- TAB: Data Explorer ----- #
  
  # ValueBox: Party (English) -----------------------------------------------
  output$infobox_fb <- renderInfoBox(
    expr = {
      infoBox(value = react_data_constituency()$DC_EN,
              icon = icon(name = "facebook-square"),
              color = "blue",
              href = react_data_constituency()$facebook,
              title = "Click this box to visit the DC's FB page")
    }
  )
  
  # ValueBox: Party (English) -----------------------------------------------
  output$infobox_party_en <- renderInfoBox(
    expr = {
      tags$div(
        tipify(
          el = infoBox(value = react_data_constituency()$Party_EN,
                       title = "Affiliated party (English)",
                       icon = icon(name = "vote-yea"),
                       color = "red",
                       fill = TRUE),
          title = "This is the political party that the DC belongs to", 
          trigger = "hover"
        ) #tipify
      ) #div
    }
  )

  # InfoBox: Constituency (English) -----------------------------------------
  output$infobox_constituency_en <- renderInfoBox(
    expr = {
      tags$div(
        tipify(
          el = infoBox(value = react_data_constituency()$Constituency_EN,
                       title = "Constituency (English)",
                       icon = icon(name = "map-signs"),
                       color = "red",
                       fill = TRUE),
          title = "This is the constituency the DC belongs to", 
          trigger = "hover"
        ) #tipify
      ) #div
    }
  )
  
}