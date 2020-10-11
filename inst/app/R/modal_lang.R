# Modal Dialog box --------------------------------------------------------
modal_lang <- function() {
  
  modalDialog(
    
    title = uiOutput(outputId = "ui_modaltitle"),

    uiOutput(outputId = "ui_modalbuttonlang"),
    
    uiOutput(outputId = "ui_modalterms"),
    hr(),
    
    # centre cookie-tracking input box, to ensure logging in
    uiOutput(outputId = "ui_modalcookies"),
    
    # only have actionButton in footer, no modalButton so not easy to close
    footer = uiOutput(outputId = "ui_modalfooter")
    
  ) #modalDialog
}