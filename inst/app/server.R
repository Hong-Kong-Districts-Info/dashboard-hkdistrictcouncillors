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
      req(input$input_region)
      
      if(input$input_region == "全部 / All"){
        return(data_master_raw)
      } else {
        data_select <- filter(.data = data_master_raw,
                              District == input$input_region)
        return(data_select)
      }
    }
  )
  
  # filter data according to user selected option
  react_constituency_dropdown <- reactive(
    x = {
      req(input$input_constituency)
      data_select <- filter(.data = data_master_raw, 
                            DropDownText == input$input_constituency)
      return(data_select)
    }
  )
  
  # convert filtered data to sf class for district map highlighting
  react_district_highlight <- reactive(
    x = {
      data_select <- st_as_sf(x = react_constituency_dropdown())
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
  

  # RenderUI: Input Region ----------------------------------------------------
  source(file = "modules/ui_inputregion.R", local = TRUE)
  
  # RenderUI: Input Constituency --------------------------------------------
  source(file = "modules/ui_inputconstituency.R", local = TRUE)
  
  # InfoBox: Web -----------------------------------------------
  source(file = "modules/infobox_web.R", local = TRUE)
  
  # InfoBox: Party -----------------------------------------------
  source(file = "modules/infobox_party.R", local = TRUE)
  
  # InfoBox: Contact ---------------------------------------------
  source(file = "modules/infobox_contact.R", local = TRUE)

  # RenderUI: FB Feed  ---------------------------------------------
  source(file = "modules/ui_fbfeed.R", local = TRUE)

  # RenderPlot: Districts ---------------------------------------------------
  source(file = "modules/leaflet_district.R", local = TRUE)
  
  
  # ----- TAB: List of DCs ----- #
  
  # RenderDT: DC Details  ---------------------------------------------
  source(file = "modules/dt_districtcouncillor.R", local = TRUE)
  

  # ----- TAB: Survey ----- #
  
  # TypeForm Survey ---------------------------------------------------------
  source(file = "modules/ui_survey.R", local = TRUE)
  
  
  # ----- TAB: Construction ----- #
  source(file = "modules/ui_infocontribute.R", local = TRUE)
  source(file = "modules/ui_dataframework.R", local = TRUE)
}
