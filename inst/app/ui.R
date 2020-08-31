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
        ),
        
        # Logo
        div(a(href = 'https://hkdistricts-info.shinyapps.io/dashboard-hkdistrictcouncillors/',
              img(src = "logo.png",
                  title = "Back to home",
                  width = "200px",
                  style = "position:fixed; left:10px; bottom:10px"
                ) #img
              ) #a
        ) #div
      
      ), # sidebarMenu
      data.step = 1,
      data.intro = "Use this sidebar to navigate around the website.",
      data.hint = "Press the icon of the three lines in the top-left to access the navigation sidebar."
    ) #introBox
  ), #dashboardSidebar
  
  # Body
  body = dashboardBody(
    
    tags$head(
      tags$head(includeHTML(("google-analytics.html"))),
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    
    tabItems(
      
      # Tab: Overview of a DC ----------------------------------------------------------
      
      tabItem(
        tabName = "tab_dcoverview",
        
        introBox(

          # Dropdown box for region; impacts ui_inputconstituency
          uiOutput(outputId = "ui_inputregion"),
          
          # Dropdown box for constituency
          uiOutput(outputId = "ui_inputconstituency"),

          data.step = 2,
          data.intro = "This search controls the options displayed on this tab."
        ), #introBox
        
        # nested introBox
        introBox(
          
          introBox(
            fluidRow(
              infoBoxOutput(outputId = "infobox_web", width = NULL)),
            data.step = 4,
            data.intro = "This shows the DC's name and if the colour is blue, means they have a FB page."
          ),
          
          introBox(
            fluidRow(
              infoBoxOutput(outputId = "infobox_party", width = NULL),
              infoBoxOutput(outputId = "phone_number", width = NULL),
              
            ),
            fluidRow(
              infoBoxOutput(outputId = "infobox_address", width = NULL),
              infoBoxOutput(outputId = "individual_page", width = NULL)
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
              width = 6,
              uiOutput(outputId = "ui_fbfeed") %>% 
                withSpinner()
            ) #column
          ), #fluidRow
          data.step = 6,
          data.intro = "This shows the latest posts by the DC on their FB page."
        ), #introBox
        
        introBox(
          fluidRow(
            box(
              solidHeader = TRUE,
              status = "success",
              width = 12,
              leafletOutput(outputId = "plot_district", width = "100%") %>% 
                withSpinner() %>% 
                helper(type = "markdown",
                       content = "plotdistrict")
            ) #box
          ), #fluidRow
          data.step = 7,
          data.intro = "This highlights the constituency boundaries, with your selected constituency being highlighted."
        ) #introBox
        
      ), #tabItem
      
      
      # Tab: List of DCs -------------------------------------------------------
      
      tabItem(
        tabName = "tab_dclist",
        
        introBox(
          fluidPage(
            DTOutput(outputId = "dt_districtcouncillor") %>% 
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
            htmlOutput(outputId = "ui_survey") %>% 
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
          uiOutput(outputId = "ui_infocontribute")
        ), #box
        
        box(
          width = 5, status = "success", solidHeader = TRUE,
          uiOutput(outputId = "ui_dataframework")
        ) #box
        
      ) #tabItem
      
    ) #tabItems
    
  ) #dashboardBody
  
  
) #dashboardPage
