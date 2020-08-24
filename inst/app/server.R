# -------- #
# server.R #
# -------- #

# DESC: Code here can be much longer and complicated than in ui.R.
#       Is where all the dynamic data manipulation happens, and plot creations.
#       e.g. Filtering based on user inputs and generating plots based on dynamically filtered data.
#       server.R must create a function called server, like below:

server <- function(input, output, session) {

  # initiate hints 
  hintjs(session = session)
  # intiate shinyhelper
  observe_helpers()
  
  # ----- REACTIVES ----- #
  
  # filter data according to user selected region
  react_region_dropdown <- reactive(
    x = {
        if(input$input_region == "全部 / All"){
          
          data_master_raw
          
        } else {
          
          
          data_select <- filter(.data = data_master_raw,
                                             District == input$input_region)
          
          return(data_select)
        }
    }
  )
  
  # filter data according to user selected option
  react_data_dropdown <- reactive(
    x = {
      
      # data_master_raw[data_master_raw$DropDownText %in% input$input_dropdowntext,]
      data_select <- filter(.data = data_master_raw,
                            DropDownText == req(input$input_dropdowntext))

      return(data_select)
    }
  )
  
  # convert filtered data to sf class for district map highlighting
  react_district_highlight <- reactive(
    x = {
      data_select <- st_as_sf(x = react_data_dropdown())
      return(data_select)
    }
  )
  
  
  # ----- OBSERVE EVENTS ----- #
  
  # Password and T&Cs Pop-up Box ---------------------------------------------------------
  
  # show modalDialog on app start-up
  showModal(modal())  
  
  # check cookie-consent and render UI if correct
  observeEvent(
    
    eventExpr = input$submit_cookieconsent,
    
    handlerExpr = {
      
      # allows access to dashboard if consent, otherwise shutdown
      if (input$button_cookieconsent == "(是) Yes, I accept tracking") {
        removeModal()
      } else {
        stopApp()
      }
    }
  )

  # Interactive Tutorial ----------------------------------------------------

  # start introjs and hide sidebar when button is pressed
  observeEvent(eventExpr = input$button_help,
               handlerExpr = {
                 introjs(session = session,
                         options = list("nextLabel" = "Next step",
                                        "prevLabel" = "Go back",
                                        "skipLabel" = "Close tutorial"),
                         events = list(onbeforechange = readCallback('switchTabs')))
                 # add class to minimise sidebar when going through tutorial - for mobile
                 addClass(selector = "body", class = "sidebar-collapse")
              }
  ) #observeEvent
  

  # ----- TAB: Overview of a DC ----- #
  
  # renderUI for second dropdown for constituency
  # dropdown filters according to selected region
  # method implemented in https://stackoverflow.com/questions/45975959/create-reactive-selectinput-flexdashboard-with-shiny
  output$constituency_dropdown <- renderUI({
    selectizeInput(inputId = "input_dropdowntext",
                   label = "請選擇或輸入選區 / Please type or select a constituency",
                   choices = react_region_dropdown()$DropDownText,
                   selected = "A01: 中環 / CHUNG WAN")
  })
  

  # InfoBox: FB -----------------------------------------------
  source(file = "modules/infobox_fb.R", local = TRUE)
  
  # InfoBox: Party -----------------------------------------------
  source(file = "modules/infobox_party.R", local = TRUE)

  # InfoBox: Constituency -----------------------------------------
  source(file = "modules/infobox_constituency.R", local = TRUE)
  
  # InfoBox: District -----------------------------------------
  output$infobox_district <- renderInfoBox(
    expr = {
      tags$div(
        infoBox(value = react_data_dropdown()$District_ZH,
                title = "區議會 / District",
                subtitle = react_data_dropdown()$District_EN,
                icon = icon(name = "map-signs"),
                color = "green",
                fill = TRUE,
                width = 6)
      ) #div
    }
  ) #renderInfoBox
  
  # InfoBox: Address -----------------------------------------
  output$infobox_address <- renderInfoBox(
    expr = {
      tags$div(
        infoBox(value = react_data_dropdown()$Address,
                title = "地址 / Address",
                # subtitle = react_data_dropdown()$District_EN,
                icon = icon(name = "map-signs"),
                color = "green",
                fill = TRUE,
                width = 6)
      ) #div
    }
  ) #renderInfoBox
  
  # InfoBox: Phone number ---------------------------------------------
  ## Make this a clickable link to the individual DC page
  output$phone_number <- renderInfoBox(
    expr = {
      tags$div(
        infoBox(value = react_data_dropdown()$Phone,
                title = "聯絡電話 / Contact number",
                # subtitle = react_data_dropdown()$Phone,
                icon = icon(name = "phone"),
                color = "green",
                fill = TRUE,
                width = 6)
      ) #div
    }
  ) #renderInfoBox
  

  # InfoBox: Individual DC Page ---------------------------------------------
  ## Make this a clickable link to the individual DC page
  output$individual_page <- renderInfoBox(
    expr = {
      tags$div(
        infoBox(value = "",
                title = "查看更多 / View more",
                subtitle = "Hong Kong Districts Info website",
                href = react_data_dropdown()$ind_page,
                icon = icon(name = "hand-pointer"),
                color = "green",
                fill = TRUE,
                width = 6)
      ) #div
    }
  ) #renderInfoBox
  

  # RenderUI: FB Feed  ---------------------------------------------
  output$frame <- renderUI(
    expr = {
      HTML(react_data_dropdown()$iframe)
    }
  ) #renderUI

  # RenderPlot: Districts ---------------------------------------------------
  source(file = "modules/leaflet_district.R", local = TRUE)
  
  # ----- TAB: List of DCs ----- #
  
  # RenderDT: DC Details  ---------------------------------------------
  source(file = "modules/dt_districtcouncillor.R", local = TRUE)
  

  # ----- TAB: Survey ----- #
  
  # TypeForm Survey ---------------------------------------------------------
  output$html_typeform = renderUI(
    expr = {
      html_typeform
    }
  ) #renderUI
  
}
