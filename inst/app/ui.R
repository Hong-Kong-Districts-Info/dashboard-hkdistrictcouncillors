# ---- #
# ui.R #
# ---- #
# DESC: Script should be relatively short and straightforward. 
#       All that happens here is setting out where things go.
#       There are no calculations.

ui <- dashboardPage(
  
  # Title and Skin
  title = "District Councillors",
  skin = "green",
  
  # Header
  header = dashboardHeader(
    title = "HK: District Councillors",
    tags$li(a(href = 'https://github.com/avisionh/dashboard-hkdistrictcouncillors/',
              icon("github"),
              title = "GitHub"),
            class = "dropdown"),
    tags$li(a(href = 'mailto: hkdistricts.info@gmail.com',
              icon("envelope"),
              title = "Email us"),
            class = "dropdown"),
    tags$li(a(href = 'https://hkdistricts-info.shinyapps.io/dashboard-hkdistrictcouncillors/',
              img(src = 'logo.png', title = "Back to Home", height = "46px"),
              style = "padding-top:2px; padding-bottom:2px;"),
            class = "dropdown")
  ),
  
  # Sidebar
  sidebar = dashboardSidebar(
    
    sidebarMenu(
      id = "menu",
      
      # Overview of a DC tab
      menuItem(
        text = "Overview of a DC",
        icon = icon(name = "user"),
        tabName = "tab_dcoverview"
      ),
      
      # DCs list tab
      menuItem(
        text = "List of DCs",
        icon = icon(name = "list-ul"),
        tabName = "tab_dclist"
      ),
      
      # TypeForm survey
      menuItem(
       text = "Survey",
       icon = icon(name = "table"),
       tabName = "tab_typeform"
      ),
      
      # construction tab
      menuItem(
        text = "Construction",
        icon = icon(name = "info-circle"),
        tabName = "tab_construction"
      )
      
    ) # sidebarMenu
  ), #dashboardSidebar
  
  # Body
  body = dashboardBody(
    
    tags$head(
      tags$head(includeHTML(("google-analytics.html")))
    ),
    
    tabItems(
      
      # Tab: Overview of a DC ----------------------------------------------------------
      
      tabItem(
        tabName = "tab_dcoverview",
        selectizeInput(inputId = "input_dropdowntext",
                    label = "請選擇或輸入選區 / Please type or select a district",
                    choices = sort(unique(data_master_raw$DropDownText))),
        

        fluidRow(
          infoBoxOutput(outputId = "infobox_fb", width = NULL)
        ),
        
        fluidRow(
          infoBoxOutput(outputId = "infobox_party_en", width = NULL),
          infoBoxOutput(outputId = "infobox_constituency_en", width = NULL)
        ),
        
        fluidRow(
          column(
            width = 3,
            uiOutput("frame") # iframe
          ) #column
          
        ), #fluidRow
        
        fluidRow(
          box(
            solidHeader = TRUE, status = "success", width = 9,
            plotOutput(outputId = "plot_district", width = NULL)
          ) #box
        ) #fluidRow
        
      ), #tabItem
      
      
      # Tab: List of DCs -------------------------------------------------------
      
      tabItem(
        tabName = "tab_dclist",
        
        fluidPage(
          DTOutput("dc_table")
        ) #fluidPage
        
      ), #tabItem
      
      
      # Tab: DC Table -----------------------------------------------------
      
      tabItem(
        tabName = "tab_dctable",
        fluidPage(
          HTML(text = "<div class=\"typeform-widget\" data-url=\"https://form.typeform.com/to/gFHC02gE\" style=\"width: 100%; height: 500px;\"></div> <script> (function() { var qs,js,q,s,d=document, gi=d.getElementById, ce=d.createElement, gt=d.getElementsByTagName, id=\"typef_orm\", b=\"https://embed.typeform.com/\"; if(!gi.call(d,id)) { js=ce.call(d,\"script\"); js.id=id; js.src=b+\"embed.js\"; q=gt.call(d,\"script\")[0]; q.parentNode.insertBefore(js,q) } })() </script> <div style=\"font-family: Sans-Serif;font-size: 12px;color: #999;opacity: 0.5; padding-top: 5px;\"> powered by <a href=\"https://admin.typeform.com/signup?utm_campaign=gFHC02gE&utm_source=typeform.com-01EENYCBWQACS4BQ2SV4V5D2C9-free&utm_medium=typeform&utm_content=typeform-embedded-poweredbytypeform&utm_term=EN\" style=\"color: #999\" target=\"_blank\">Typeform</a> </div>")
        )
      ), #tabItem
      
      
      # Tab: TypeForm -----------------------------------------------------
      
      tabItem(
        tabName = "tab_typeform"
        
      ), #tabItem
      
      
      # Tab: Construction ---------------------------------------------------

      tabItem(
        tabName = "tab_construction",
        
        box(
          width = 7, status = "success", solidHeader = TRUE,
          
          # Further Information
          h2(icon("info"), "更多資訊 / Further Information"), hr(),
          
          div(
            "此頁旨在簡介此網站的製作方法，以及參與的途徑。",
            p("此網站旨在提供一站式資源，方便各位尋找和瀏覽香港各區區議員的 Facebook 專頁。"),
            p(strong("此網站並不從屬於任何政治人物或運動。"))
          ),
          hr(),
          div(
            "On this tab, we describe how this website was constructed and ways to contribute.",
            p("Note, the aim of this app is to provide a convenient site for accessing the Facebook pages of district councillors in Hong Kong."),
            p(strong("This website is not affiliated to any political individuals nor movements."))
          ),
          
          # Want to contribute?
          h2(icon("question-circle-o"), "想參與製作本網站 / Want to contribute?"), hr(),
          div(
            "若你有興趣參與製作本網站，請與我們聯絡！",
            p("你可以透過網站右上方的 Github 及電郵連結聯絡我們。"),
            p("參與前，請先閱讀參與 ", 
              a(href = "https://github.com/avisionh/dashboard-hkdistrictcouncillors/blob/feature/code-coverage/CODE_OF_CONDUCT.md", 
                "製作者守則"), ".")
          ),
          hr(),
          div(
            "If you wish to contribute to the project, do get in touch!",
            p("You can contact us via the Octocat and Mail buttons at the top-right of the website."),
            p("Please also read the ", 
              a(href = "https://github.com/avisionh/dashboard-hkdistrictcouncillors/blob/feature/code-coverage/CODE_OF_CONDUCT.md", 
                "Contributor Code of Conduct"), "
              before contributing.")
          ), hr()
          
        ), #box
        
        box(
          width = 5, status = "success", solidHeader = TRUE,
          
          # Where is the data from?
          h2(icon("database"), "資料及數據來源 / Where is the data from?"), hr(),
          
          
          div(
            "此網站使用來自下列來源的資料及數據 / This app uses data from: ", br(),
            tags$ul(
              tags$li(a(href = "https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/edit#gid=0", "Google Sheet of HK DCs")),
              tags$li(a(href = "https://en.wikipedia.org/wiki/2019_Hong_Kong_local_elections", "Wikipedia of HK DCs")),
              tags$li("Facebook pages of each HK DC"),
              tags$li(a(href = "https://gadm.org/", "Shapefiles of HK")),
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
          
        ) #box
        
      ) #tabItem
      
    ) #tabItems
    
  ) #dashboardBody
  
  
) #dashboardPage
