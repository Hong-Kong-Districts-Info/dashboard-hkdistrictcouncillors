output$ui_modalterms <- renderUI(
  expr = {
    
    HTML(
      text = paste0(
        p(react_lang()$t("You understand that the following applies to this website. By proceeding further, you are agreeing to these Terms of Use.")),
        div(
          tags$ul(
            tags$li(react_lang()$t("We are not affiliated to any political individuals nor movements.")), br(),
            tags$li(react_lang()$t("We are not liable for any potential misuses.")), br(),
            tags$li(react_lang()$t("We use tracking cookies to give you the best online experience."))
          ), br(),
        ) #div
      ) #paste0
    ) #HTML
    
  }
)