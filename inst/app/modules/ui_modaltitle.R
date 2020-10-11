output$ui_modaltitle <- renderUI(
  expr = {
    HTML(
      text = paste0(
        div(style = "text-align: center;",
            img(src = "logo.png", height = "100px"),
            p(strong(react_lang()$t("Terms of Use")))
        ) #div
      ) #paste0
    ) #HTML
  }
)