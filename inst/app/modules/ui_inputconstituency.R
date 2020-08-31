output$ui_inputconstituency <- renderUI(
  expr = {
    selectizeInput(inputId = "input_constituency",
                   label = "Please type or select a constituency",
                   choices = react_region_dropdown()$DropDownText,
                   selected = "A01: 中環 / CHUNG WAN") %>% 
      helper(type = "markdown",
             content = "dropdowntext")
  }
)