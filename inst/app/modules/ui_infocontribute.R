output$ui_infocontribute <- renderUI(
  expr = {
    
    HTML(
      text = paste0(
        # Further Information
        h2(icon("info"), react_lang()$t("Further Information")), hr(),
        
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
      ) #paste0
    ) #HTML
  }
)