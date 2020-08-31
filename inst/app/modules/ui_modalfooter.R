output$ui_modalfooter <- renderUI(
  expr = {
    tagList(
      div(style = "text-align: center;",
          actionButton(inputId = "submit_cookieconsent", 
                       label = react_lang()$t("Submit"))
      ) #div
    ) #tagList
  }
)