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
  
  # filter data according to user selected option
  react_data_dropdown <- reactive(
    x = {
      data_select <- filter(.data = data_master_raw, 
                            DropDownText == input$input_dropdowntext)
      
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
  
  # InfoBox: Party (English) -----------------------------------------------
  output$infobox_fb <- renderInfoBox(
    expr = {
      tags$div(
        infoBox(value = paste0(react_data_dropdown()$DC_ZH, " / ", react_data_dropdown()$DC_EN),
                icon = icon(name = "facebook-square"),
                color = react_data_dropdown()$exists_fb,
                href = react_data_dropdown()$facebook,
                title = "區議員名稱 / DC's name",
                subtitle = "按此格到區議員的面書專頁 / Click this box to visit their FB page.",
                width = 12)
      ) #div
    }
  ) #renderInfoBox
  
  # InfoBox: Party (English) -----------------------------------------------
  output$infobox_party <- renderInfoBox(
    expr = {
      tags$div(
        infoBox(value = react_data_dropdown()$Party_ZH,
                title = "黨派 / Affiliated party",
                subtitle = react_data_dropdown()$Party_EN,
                icon = icon(name = "vote-yea"),
                color = "green",
                fill = TRUE,
                width = 6)
      ) #div
    }
  ) #renderInfoBox

  # InfoBox: Constituency (English) -----------------------------------------
  output$infobox_constituency <- renderInfoBox(
    expr = {
      tags$div(
        infoBox(value = react_data_dropdown()$Constituency_ZH,
                title = "選區 / Constituency",
                subtitle = react_data_dropdown()$Constituency_EN,
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
                subtitle = react_data_dropdown()$Phone,
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
                subtitle = "",
                href = react_data_dropdown()$ind_page,
                icon = icon(name = "hand-pointer"),
                color = "green",
                fill = TRUE,
                width = 6)
      ) #div
    }
  ) #renderInfoBox
  
  

  # RenderUI: FB Feed  ---------------------------------------------
  output$frame <- renderUI({
    HTML(react_data_dropdown()$iframe)
  })


  # RenderPlot: Districts ---------------------------------------------------
  output$plot_district <- renderLeaflet(
    expr = {
      
      map_hk_districts %>% 
        addPolygons(data = react_district_highlight(),
                    color = '#D55E00',
                    weight = 0.5,
                    fillOpacity = 0.6) %>% 
        addPopups(lng = react_district_highlight()$centroids[,"X"],
                  lat = react_district_highlight()$centroids[,"Y"], 
                  popup = react_district_highlight()$DropDownText) %>% 
        # centre map on user-chosen district
        setView(lng = react_district_highlight()$centroids[,"X"],
                lat = react_district_highlight()$centroids[,"Y"], 
                zoom = 11)
      
    }
  )

  
  # ----- TAB: List of DCs ----- #
  
  # RenderDT: DC Details  ---------------------------------------------
  
  output$dc_table = renderDT(
    expr = {
      select(.data = data_master_raw,
             Region,
             District,
             Constituency = DropDownText,
             DC)
    }, #expr
    filter = "top",
    rownames = FALSE,
    options = list(lengthMenu = list(c(10, 20, -1),
                                     c('10', '20', 'All')),
                   pageLength = 20,
                   buttons = list(
                     list(
                       extend = "collection",
                       text = 'Show All',
                       action = DT::JS("function ( e, dt, node, config ) {
                                    dt.page.len(-1);
                                    dt.ajax.reload();
                                }")
                     ) #list
                  ) #list
    ) #list

  ) #renderDT
  

  # ----- TAB: Survey ----- #
  
  # TypeForm Survey ---------------------------------------------------------
  output$html_typeform = renderUI(
    expr = {
      html_typeform
    }
  ) #renderUI
  
}