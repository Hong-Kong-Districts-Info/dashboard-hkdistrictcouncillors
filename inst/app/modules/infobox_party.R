output$infobox_party <- renderInfoBox(
  expr = {
    tags$div(
      infoBox(value = react_constituency_dropdown()$Party_ZH,
              title = react_lang()$t("Affiliated party"),
              subtitle = react_constituency_dropdown()$Party_EN,
              icon = icon(name = "vote-yea"),
              color = "green",
              fill = TRUE,
              width = 6)
    ) #div
  }
) #renderInfoBox