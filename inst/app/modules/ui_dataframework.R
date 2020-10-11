output$ui_dataframework <- renderUI(
  expr = {
    
    HTML(
      text = paste0(
        # Where is the data from?
        h2(icon("database"), react_lang()$t("Where is the data from?")), hr(),
        
        div(
          react_lang()$t("This app uses data from: "), br(),
          tags$ul(
            tags$li(a(href = "https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/edit#gid=0", "Google Sheet of HK DCs")),
            tags$li(a(href = "https://en.wikipedia.org/wiki/2019_Hong_Kong_local_elections", "Wikipedia of HK DCs")),
            tags$li("Facebook pages of each HK DC"),
            tags$li(a(href = "https://accessinfo.hk/en/request/shapefileshp_for_2019_district_c", "Shapefiles of HK district councils"))
          )
        ), hr(),
        
        # What is the framework?
        h2(icon("cogs"), react_lang()$t("What is the framework?")), hr(),
        
        div(
          react_lang()$t("This app has been built using: "), br(),
          tags$ul(
            tags$li(a(href = "https://www.r-project.org/", "R"), react_lang()$t("(for the data processing and calculation)")),
            tags$li(a(href = "https://shiny.rstudio.com/", "R Shiny", target = "_blank"), react_lang()$t("(for the app design and interactivity)")),
            tags$li(a(href = "https://rstudio.github.io/shinydashboard/", "Shiny Dashboard", target = "_blank"), react_lang()$t("(for the app layout and structure)"))
          )
        ), hr()
        
      ) #paste0
    ) #HTML
  }
)