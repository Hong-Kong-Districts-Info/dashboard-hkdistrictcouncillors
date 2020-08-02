# Modal Dialog box --------------------------------------------------------
modal <- function(failed = FALSE) {
  
  modalDialog(
    
    title = div(style = "text-align: center;",
                img(src = "logo.png", height = "100px"),
                p(strong("Terms of Use"))),
    
    p("You understand that the following applies to this website:"),
    tags$ul(
      tags$li("We are not affiliated to any political individuals nor movements."), br(),
      tags$li("We are not liable for any potential misuses."), br(),
      tags$li("We use tracking cookies to give you the best online experience.")
    ), br(),
    
    "By proceeding further, you are agreeing to these Terms of Use.", br(), br(),
    
    # centre cookie-tracking input box, to ensure logging in
    div(style = "margin-left:auto; margin-right:auto; text-align:center;",
        radioButtons(inputId = "button_cookieconsent",
                     label = "Do you want to proceed and have tracking cookies enabled?",
                     choices = c("Yes, I accept tracking", "No, I wish to exit the website"),
                     selected = "No, I wish to exit the website",
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