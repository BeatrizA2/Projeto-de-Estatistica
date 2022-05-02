library(shiny)
library(shinydashboard)

dataset <- read.csv(file = "dataset.csv")
View(dataset)
libraries <- colnames(dataset)

months <- c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D")

ui <- dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Comparação", tabName = "Comparação", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "dashboard",
        box(plotOutput("histo"), heigth = 200),
        box(plotOutput("boxpl"), height = 425),
        box(selectInput(inputId = "library1",label = "Primeira biblioteca",
                        choices = libraries[-1]) , width = 4),
        box(selectInput(
          inputId = "year1",
          label = "Ano analisado",
          choices = seq(2009, 2019)),
          width = 4)),
      tabItem(tabName = "Comparação"))
    )
  )

server <- function(input, output){
  output$histo <- renderPlot({
    year <- as.numeric(input$year1)
    start <- ((year %% 2009) * 12) + 1
    end <-  start + 11
    
    coluna <- as.numeric(dataset[[input$library1]])
    
    coluna <- coluna[start:end]
    hist(coluna, breaks = 12, xlab = "N° de perguntas", ylab ="Frequência")
  })
  output$boxpl <- renderPlot({
    year <- as.numeric(input$year1)
    start <- ((year %% 2009) * 12) + 1
    end <-  start + 11
    
    coluna <- as.numeric(dataset[[input$library1]])
    
    coluna <- coluna[start:end]
    boxplot(coluna, main = "Boxplot")
  })
}

shinyApp(ui, server)
