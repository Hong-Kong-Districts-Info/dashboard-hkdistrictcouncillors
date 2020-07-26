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
  
  
  # ----- TAB: Overview of a DC ----- #
  
  # ValueBox: Party (English) -----------------------------------------------
  output$infobox_fb <- renderInfoBox(
    expr = {
      tags$div(
        tipify(
          el = infoBox(value = paste0(react_data_dropdown()$DC_ZH, " / ", react_data_dropdown()$DC_EN),
                       icon = icon(name = "facebook-square"),
                       color = react_data_dropdown()$exists_fb,
                       href = react_data_dropdown()$facebook,
                       title = "區議員名稱 / DC's name",
                       subtitle = "按此格到區議員的面書專頁 / Click this box to visit their FB page.",
                       width = 12),
          title = "If it does not re-direct to their FB page, this means their FB page does not exist or we could not find it.",
          trigger = "hover",
          placement = "left"
        ) #tipify
      ) #div
    }
  ) #renderInfoBox
  
  # ValueBox: Party (English) -----------------------------------------------
  output$infobox_party_en <- renderInfoBox(
    expr = {
      tags$div(
        tipify(
          el = infoBox(value = react_data_dropdown()$Party_ZH,
                       title = "黨派 / Affiliated party",
                       subtitle = react_data_dropdown()$Party_EN,
                       icon = icon(name = "vote-yea"),
                       color = "red",
                       fill = TRUE,
                       width = 6),
          title = "This is the political party that the DC belongs to", 
          trigger = "hover",
          placement = "bottom"
        ) #tipify
      ) #div
    }
  ) #renderInfoBox

  # InfoBox: Constituency (English) -----------------------------------------
  output$infobox_constituency_en <- renderInfoBox(
    expr = {
      tags$div(
        tipify(
          el = infoBox(value = react_data_dropdown()$Constituency_ZH,
                       title = "選區 / Constituency",
                       subtitle = react_data_dropdown()$Constituency_EN,
                       icon = icon(name = "map-signs"),
                       color = "red",
                       fill = TRUE,
                       width = 6),
          title = "This is the constituency the DC belongs to", 
          trigger = "hover",
          placement = "bottom"
        ) #tipify
      ) #div
    }
  ) #renderInfoBox
  
  
  # iframe  ---------------------------------------------
  output$frame <- renderUI({
    HTML(react_data_dropdown()$iframe)
  })


  # RenderPlot: Districts ---------------------------------------------------
  output$plot_district <- renderPlot(
    expr = {
      
      map_hk_districts +
        geom_sf(data = react_district_highlight(), fill = '#D55E00', alpha = 0.5)
      
    }
  )
  
  
  # ----- TAB: List of DCs ----- #
  
  # Data Table with DC Details  ---------------------------------------------
  
  output$dc_table = renderDT(
    select(.data = data_master_raw,
           Constituency = DropDownText,
           Party,
           DC,
           Region,
           District,
           FB = "facebook"),
    filter = "top",
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
  
}