# Modal Dialog box --------------------------------------------------------
modal_lang <- function() {
  
  modalDialog(
    
    title = div(style = "text-align: center;",
                img(src = "logo.png", height = "100px"),
                p(strong("Terms of Use"))),

    radioButtons(inputId = "button_language",
                 label = "Please select a language",
                 choiceNames = c("中文", "English"),
                 choiceValues = c("zh", "en"),
                 selected = "zh"),
    
    uiOutput(outputId = "ui_modalterms"),
    hr(),
    
    # centre cookie-tracking input box, to ensure logging in
    div(style = "margin-left:auto; margin-right:auto; text-align:center;",
        radioButtons(inputId = "button_cookieconsent",
                     label = cat("您是否願意繼續並啟用跟踪Cookie嗎?\nDo you want to proceed and have tracking cookies enabled?"),
                     choices = c("(是) Yes, I accept tracking", 
                                 "(否) No, I wish to exit the website"),
                     selected = "(否) No, I wish to exit the website",
                     inline = TRUE)
    ),
    
    # only have actionButton in footer, no modalButton so not easy to close
    footer = tagList(
      div(style = "text-align: center;",
          actionButton(inputId = "submit_cookieconsent", label = "Submit choice")
      )
    )
    
  ) #modalDialog
}