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