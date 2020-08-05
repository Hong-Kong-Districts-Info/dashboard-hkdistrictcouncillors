# Modal Dialog box --------------------------------------------------------
modal <- function(failed = FALSE) {
  
  modalDialog(
    
    title = div(style = "text-align: center;",
                img(src = "logo.png", height = "100px"),
                p(strong("使用條款 / Terms of Use"))),
    
    p("您了解以下內容適用於本網站:"),
    
    tags$ul(
      tags$li("本網站不隸屬於任何政治人物或運動。"), br(),
      tags$li("本網站對任何潛在的濫用不承擔任何責任。"), br(),
      tags$li("本網站使用跟踪cookie為您提供最佳的在線體驗。")
    ), br(),
    
    p("如要繼續使用本網站，即表示您同意以上使用條款。"),
    
    hr(),
    
    p("You understand that the following applies to this website:"),
    
    tags$ul(
      tags$li("We are not affiliated to any political individuals nor movements."), br(),
      tags$li("We are not liable for any potential misuses."), br(),
      tags$li("We use tracking cookies to give you the best online experience.")
    ), br(),
    
    p("By proceeding further, you are agreeing to these Terms of Use."),
    
    hr(),
    
    # centre cookie-tracking input box, to ensure logging in
    div(style = "margin-left:auto; margin-right:auto; text-align:center;",
        radioButtons(inputId = "button_cookieconsent",
                     label = cat("您願意繼續並啟用跟踪Cookie嗎?\nDo you want to proceed and have tracking cookies enabled?"),
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