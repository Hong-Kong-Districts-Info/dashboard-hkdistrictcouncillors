# InfoBox: Party -----------------------------------------------
output$infobox_web <- renderInfoBox(
  expr = {
    tags$div(
      infoBox(value = paste0(react_constituency_dropdown()$DC_ZH, " / ", react_constituency_dropdown()$DC_EN),
              icon = icon(name = "globe-asia"),
              color = react_constituency_dropdown()$exists_web,
              href = react_constituency_dropdown()$ind_page,
              title = "區議員名稱 / DC's name",
              subtitle = react_constituency_dropdown()$Address,
              width = 12) %>% 
        helper(type = "markdown",
               content = "infoboxweb")
    ) #div
  }
) #renderInfoBox