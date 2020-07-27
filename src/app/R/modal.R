# Modal Dialog box --------------------------------------------------------
modal <- function(failed = FALSE) {
  
  modalDialog(
    
    title = tags$b("Terms of Use"),
    
    "You understand that the following applies to this website:", br(), br(),
    tags$ul(
      tags$li("We are not affiliated to any political individuals nor movements."), br(),
      tags$li("We are not liable for any potential misuses."), br(),
      tags$li("We use tracking cookies to give you the best online experience.")
    ), br(),
    
    "By proceeding further, you are agreeing to these Terms of Use.", br(), br(),
    
    # centre cookie-tracking input box, to ensure logging in
    div(style = "width: 200px ;
        margin-left: auto ;
        margin-right: auto ;
        text-align: center;",
        radioButtons(inputId = "button_cookieconsent",
                     label = "Do you want to proceed and have tracking cookies enabled?",
                     choices = c("Yes", "No"),
                     selected = "No",
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