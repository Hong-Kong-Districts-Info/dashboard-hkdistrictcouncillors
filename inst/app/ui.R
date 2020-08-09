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
    tags$li(actionLink(inputId = "button_help", 
                       label = "Tutorial"),
            class = "dropdown"),
    tags$li(a(href = 'https://hong-kong-districts-info.github.io/',
              icon(name = 'globe-asia'),
              title = 'Website'),
            class = "dropdown"),
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
    
    introjsUI(),
    useShinyjs(),
    
    introBox(
      sidebarMenu(
        id = "menu",
        
        # Overview of a DC tab
        menuItem(
          text = "Overview of a DC",
          icon = icon(name = "user"),
          tabName = "tab_dcoverview"
        ),
        
        # List of DCs tab
        menuItem(
          text = "List of DCs",
          icon = icon(name = "list-ul"),
          tabName = "tab_dclist"
        ),
        
        # Survey tab
        menuItem(
         text = "Complete our survey",
         icon = icon(name = "edit"),
         badgeLabel = "new",
         badgeColor = "green",
         tabName = "tab_survey"
        ),
      
        # Construction tab
        menuItem(
          text = "How this was made",
          icon = icon(name = "info-circle"),
          tabName = "tab_construction"
        )
      
      ), # sidebarMenu
      data.step = 1,
      data.intro = "Use this sidebar to navigate around the website.",
      data.hint = "Press the icon of the three lines in the top-left to access the navigation sidebar."
    ) #introBox
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
        
        introBox(
          selectizeInput(inputId = "input_dropdowntext",
                         label = "請選擇或輸入選區 / Please type or select a constituency",
                         choices = sort(unique(data_master_raw$DropDownText))) %>% 
            helper(type = "markdown",
                   content = "dropdowntext"),
          data.step = 2,
          data.intro = "This search controls the options displayed on this tab."
        ), #introBox
        
        # nested introBox
        introBox(
          
          introBox(
            fluidRow(
              infoBoxOutput(outputId = "infobox_fb", width = NULL)
            ),
            data.step = 4,
            data.intro = "This shows the DC's name and if the colour is blue, means they have a FB page.",
            data.hint = "Click on this to access their public FB page."
          ),
          
          introBox(
            fluidRow(
              infoBoxOutput(outputId = "infobox_party", width = NULL),
              infoBoxOutput(outputId = "infobox_constituency", width = NULL)
            ),
            data.step = 5,
            data.intro = "These show the party and consituency of the DC selected."
          ),
          
          data.step = 3,
          data.intro = "These tiles provide basic information relating to the contituency selected."
        
        ), #introBox
        
        introBox(
          fluidRow(
            column(
              width = 3,
              uiOutput("frame") %>% 
                withSpinner()
            ) #column
          ), #fluidRow
          data.step = 6,
          data.intro = "This shows the latest posts by the DC on their FB page."
        ), #introBox
        
        introBox(
          fluidRow(
            box(
              solidHeader = TRUE, status = "success",
              leafletOutput(outputId = "plot_district", width = "100%") %>% 
                withSpinner()
            ) #box
          ), #fluidRow
          data.step = 7,
          data.intro = "This highlights the constituency boundaries, with your selected constituency being highlighted.",
          data.hint = "You can also use this to find the name of your constituency by selecting your region on the map."
        ) #introBox
        
      ), #tabItem
      
      
      # Tab: List of DCs -------------------------------------------------------
      
      tabItem(
        tabName = "tab_dclist",
        
        introBox(
          fluidPage(
            DTOutput(outputId = "dc_table") %>% 
              withSpinner()
          ), #fluidPage
          data.step = 8,
          data.intro = "This table shows all the DCs and their associated info."
        )
        
      ), #tabItem
      
      
      # Tab: Survey -----------------------------------------------------
      
      tabItem(
        tabName = "tab_survey",
        
        introBox(
          fluidPage(
            htmlOutput(outputId = "html_typeform") %>% 
              withSpinner()
          ), #fluidPage
          data.step = 9,
          data.intro = "Don't forget to provide us with feedback. :)"
        ) #introBox
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
