output$ui_modalcookies <- renderUI(
  expr = {
    HTML(
      text = paste0(
        div(style = "margin-left:auto; margin-right:auto; text-align:center;",
            radioButtons(inputId = "button_cookieconsent",
                         label = react_lang()$t("Do you want to proceed and have tracking cookies enabled?"),
                         choices = c(react_lang()$t("Yes, I accept tracking"),
                                     react_lang()$t("No, I wish to exit the website")),
                         selected = react_lang()$t("No, I wish to exit the website"),
                         inline = TRUE)
        ) #div
      ) #paste0
    ) #HTML
  }
)