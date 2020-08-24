output$ui_inputconstituency <- renderUI(
  expr = {
    selectizeInput(inputId = "input_constituency",
                   label = "Please type or select a constituency",
                   choices = sort(unique(data_master_raw$DropDownText))) %>% 
      helper(type = "markdown",
             content = "dropdowntext")
  }
)