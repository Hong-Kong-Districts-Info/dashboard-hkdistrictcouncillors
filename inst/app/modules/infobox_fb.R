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