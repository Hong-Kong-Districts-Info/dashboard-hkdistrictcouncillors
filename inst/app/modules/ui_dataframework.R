output$ui_dataframework <- renderUI(
  expr = {
    
    HTML(
      text = paste0(
        # Where is the data from?
        h2(icon("database"), "資料及數據來源 / Where is the data from?"), hr(),
        
        div(
          "此網站使用來自下列來源的資料及數據 / This app uses data from: ", br(),
          tags$ul(
            tags$li(a(href = "https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/edit#gid=0", "Google Sheet of HK DCs")),
            tags$li(a(href = "https://en.wikipedia.org/wiki/2019_Hong_Kong_local_elections", "Wikipedia of HK DCs")),
            tags$li("Facebook pages of each HK DC"),
            tags$li(a(href = "https://accessinfo.hk/en/request/shapefileshp_for_2019_district_c", "Shapefiles of HK district councils"))
          )
        ), hr(),
        
        # What is the framework?
        h2(icon("cogs"), "製作框架 / What is the framework?"), hr(),
        
        div(
          "此網站以下列框架編寫及製作: ", br(),
          tags$ul(
            tags$li(a(href = "https://www.r-project.org/", "R"), "(數據處理及計算)"),
            tags$li(a(href = "https://shiny.rstudio.com/", "R Shiny", target = "_blank"), "(網站設計及互動功能)"),
            tags$li(a(href = "https://rstudio.github.io/shinydashboard/", "Shiny Dashboard", target = "_blank"), "(網站佈局及結構)")
          )
        ), 
        hr(),
        div(
          "This app has been built using: ", br(),
          tags$ul(
            tags$li(a(href = "https://www.r-project.org/", "R"), "(for the data processing and calculation)"),
            tags$li(a(href = "https://shiny.rstudio.com/", "R Shiny", target = "_blank"), "(for the app design and interactivity)"),
            tags$li(a(href = "https://rstudio.github.io/shinydashboard/", "Shiny Dashboard", target = "_blank"), "(for the app layout and structure)")
          )
        ), hr()
        
      ) #paste0
    ) #HTML
  }
)