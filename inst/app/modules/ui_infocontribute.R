output$ui_infocontribute <- renderUI(
  expr = {
    
    HTML(
      text = paste0(
        # Further Information
        h2(icon("info"), react_lang()$t("Further Information")), hr(),
        
        div(
          react_lang()$t("On this tab, we describe how this website was constructed and ways to contribute."),
          p(react_lang()$t("Note, the aim of this app is to provide a convenient site for accessing the Facebook pages of district councillors in Hong Kong.")),
          p(strong(react_lang()$t("This website is not affiliated to any political individuals nor movements.")))
        ),
        
        # Want to contribute?
        h2(icon("question-circle-o"), react_lang()$t("Want to contribute?")), hr(),
        div(
          react_lang()$t("If you wish to contribute to the project, do get in touch!"),
          p(react_lang()$t("You can contact us via the Octocat and Mail buttons at the top-right of the website.")),
          p(react_lang()$t("Please also read the "), 
            a(href = "https://github.com/avisionh/dashboard-hkdistrictcouncillors/blob/feature/code-coverage/CODE_OF_CONDUCT.md", 
              react_lang()$t("Contributor Code of Conduct")), ".")
        ), hr()
      ) #paste0
    ) #HTML
  }
)