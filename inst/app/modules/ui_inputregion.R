output$ui_inputregion <- renderUI(
  expr = {
    selectizeInput(inputId = "input_region",
                   label = react_lang()$t("Please type or select a district"),
                   choices = c("全部 / All", unique(data_master_raw$District)),
                   selected = "全部 / All") %>% 
      helper(type = "markdown",
             content = "dropdowntext")
  }
)