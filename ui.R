# ---- #
# ui.R #
# ---- #
# DESC: Script should be relatively short and straightforward. 
#       All that happens here is setting out where things go.
#       There are no calculations.

ui <- dashboardPage(
  
  # Title and Skin
  title = "District Councillors",
  skin = "red",
  
  # Header
  header = dashboardHeader(
    title = "Hong Kong: District Councillors"
  ),
  
  # Sidebar
  sidebar = dashboardSidebar(
    
    sidebarMenu(
      id = "menu",
      
      # Guidance tab
      menuItem(
        text = "Guidance",
        icon = icon(name = "info-circle"),
        tabName = "tab_guidance"
      ),
      
      # DCs list tab
      menuItem(
        text = "List of DCs",
        icon = icon(name = "list-ul"),
        tabName = "tab_dclist"
      ),
      
      # DC updates tab
      menuItem(
        text = "FB updates of DC",
        icon = icon(name = "window-maximize"),
        tabName = "tab_dcupdate"
      )
      
    ) # sidebarMenu
  ), #dashboardSidebar
  
  # Body
  body = dashboardBody(
    tabItems(
      
      # Tab: Guidance ---------------------------------------------------
      tabItem(
        tabName = "tab_guidance",
        
        box(
          width = 7, status = "danger", solidHeader = TRUE,
          
          # Welcome
          h2(icon("info"), "Welcome"), hr(),
          
          div(
            "Welcome to an app of Facebook page updates by Hong Kong District Councillors.",
            p("The aim of this app is to provide a convenient site for live information on the district councillors in Hong Kong, 
              via aggregating posts and feeds from their public Facebook pages. ."),
            p(strong("This app is not affiliated to any political individuals nor movements."))
          ),
          
          # Using the app
          h2(icon("users"), "Using the App"), hr(), 
          
          div(
            "Each of the tabs in the app are designed to do the following things:",
            tags$ul(
              tags$li("Navigate across different tabs by clicking on the options in the left-hand black vertical box."),
              tags$li("The ", strong("title"), " tab generic information.")
            )
          ),
          
          h2(icon("question-circle-o"), "Further Information"), hr(),
          div(
            "Useful information about the Data Sources used, the 
            Construction and Security of the app are placed in the box on 
            the right hand side of this page. Please send any questions or feedback to ", 
            a(href = "mailto:a_vision@hotmail.co.uk", "my email"),
            " or to my ", a(href = "github.com/avisionh", "GitHub.")
          ), hr()
          
        ), #box
        
        box(
          width = 5, status = "danger", solidHeader = TRUE,
          
          # Data Sources
          h2(icon("database"), "Data Sources"), hr(),
          
          div(
            "This app uses data from: ", br(),
            tags$ul(
              tags$li("Data Item 1"),
              tags$li("Data Item 2"),
              tags$li("Data Item 3")
            )
          ), hr(),
          
          # Construction
          h2(icon("cogs"), "Construction"), hr(),
          
          div(
            "This app has been constructed using: ", br(),
            tags$ul(
              tags$li(a(href = "https://www.r-project.org/", "R"), "(for the data processing and calculation)"),
              tags$li(a(href = "https://shiny.rstudio.com/", "R Shiny", target = "_blank"), "(for the app design and interactivity)"),
              tags$li(a(href = "https://rstudio.github.io/shinydashboard/", "Shiny Dashboard", target = "_blank"), "(for the app layout and structure)")
            )
          ), hr()
          
        ) #box
        
      ), #tabItem
      
      
      # Tab: Data Explorer ----------------------------------------------------------
      
      tabItem(
        tabName = "tab_dclist",
        selectInput(inputId = "input_consituency_en",
                    label = "Please choose a constituency",
                    choices = sort(unique(data_master_raw$Constituency_EN))),
        selectInput(inputId = "input_constituency_zh",
                    label = "Please choose a constituency",
                    choices = sort(unique(data_master_raw$Constituency_ZH))),
        
        column(
          width = 12,
          
          fluidRow(
            infoBoxOutput(outputId = "infobox_fb", width = NULL)
          ),
          
          fluidRow(
            valueBoxOutput(outputId = "valuebox_party_en", width = NULL),
            infoBoxOutput(outputId = "infobox_constituency_en", width = NULL)
          )
        )
      ), #tabItem
      
      
      # Tab: MI Report -------------------------------------------------------
      
      tabItem(
        tabName = "tab_dcupdate"
        
      ) #tabItem
      
    ) #tabItems
    
  ) #dashboardBody
  
  
) #dashboardPage