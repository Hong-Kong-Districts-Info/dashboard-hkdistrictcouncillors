# InfoBox: Contact -----------------------------------------------
output$infobox_contact <- renderInfoBox(
  expr = {
    tags$div(
      infoBox(value = react_constituency_dropdown()$Phone,
              title = "Phone and email",
              subtitle = react_constituency_dropdown()$Email,
              icon = icon(name = "address-card"),
              color = "green",
              fill = TRUE,
              width = 6)
    ) #div
  }
) #renderInfoBox