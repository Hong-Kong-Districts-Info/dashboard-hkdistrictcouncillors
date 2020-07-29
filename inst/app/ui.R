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
      
      # DCs list tab
      menuItem(
        text = "Overview of a DC",
        icon = icon(name = "search"),
        tabName = "tab_dcoverview"
      ),
      
      # DCs list tab
      menuItem(
        text = "List of DCs",
        icon = icon(name = "list-ul"),
        tabName = "tab_dclist"
      ),
      
      # DCs list tab
      #menuItem(
      #  text = "Details",
      #  icon = icon(name = "table"),
      #  tabName = "tab_dctable"
      #)
      
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
                    label = "請選擇選區 / Please choose a district",
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
          ), #column
          
          box(
              solidHeader = TRUE, status = "success", width = 9,
              plotOutput(outputId = "plot_district", width = NULL)
          ) #box
        )
        
      ), #tabItem
      
      
      # Tab: List of DCs -------------------------------------------------------
      
      tabItem(
        tabName = "tab_dclist",
        
        fluidPage(
          DTOutput("dc_table")
        ) #fluidPage
        
      ), #tabItem
      
      
      # Tab: DC Appendix -----------------------------------------------------
      
      tabItem(
        tabName = "tab_dctable"
        
      ), #tabItem
      
      
      # Tab: Construction ---------------------------------------------------

      tabItem(
        tabName = "tab_construction",
        
        box(
          width = 7, status = "success", solidHeader = TRUE,
          
          # Further Information
          h2(icon("info"), "Further Information"), hr(),
          
          div(
            "On this tab, we describe how this website was constructed and ways to contribute.",
            p("Note, the aim of this app is to provide a convenient site for accessing the Facebook pages of district councillors in Hong Kong."),
            p(strong("This website is not affiliated to any political individuals nor movements."))
          ),
          
          # How to use the website?
          h2(icon("users"), "How to use the website?"), hr(), 
          
          div(
            "Each of the tabs in the app are designed to do the following things:",
            tags$ul(
              tags$li("Navigate across different tabs by clicking on the options in the left-hand black vertical box."),
              tags$li("The ", strong("title"), " tab generic information.")
            )
          ),
          
          # Want to contribute?
          h2(icon("question-circle-o"), "Want to contribute?"), hr(),
          div(
            "If you wish to contribute to the project, do get in touch!",
            p("You can contact us via the Octocat and Mail buttons at the top-right of the website."),
            p("Please also read the ", 
              a(href = "https://accessinfo.hk/en/request/shapefileshp_for_2019_district_c", 
                "Contributor Code of Conduct"), "
              before contributing.")
          ), hr()
          
        ), #box
        
        box(
          width = 5, status = "success", solidHeader = TRUE,
          
          # Where is the data from?
          h2(icon("database"), "Where is the data from?"), hr(),
          
          div(
            "This app uses data from: ", br(),
            tags$ul(
              tags$li(a(href = "https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/edit#gid=0", "Google Sheet of HK DCs")),
              tags$li(a(href = "https://en.wikipedia.org/wiki/2019_Hong_Kong_local_elections", "Wikipedia of HK DCs")),
              tags$li("Facebook pages of each HK DC"),
              tags$li(a(href = "https://gadm.org/", "Shapefiles of HK")),
              tags$li(a(href = "https://accessinfo.hk/en/request/shapefileshp_for_2019_district_c", "Shapefiles of HK district councils"))
            )
          ), hr(),
          
          # What is the framework?
          h2(icon("cogs"), "What is the framework?"), hr(),
          
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