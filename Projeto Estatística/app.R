library(shiny)
library(shinydashboard)

dataset <- read.csv(file = "dataset.csv")
libraries <- colnames(dataset)

months <- c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D")

ui <- dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(),
  dashboardBody(
    box(plotOutput("correlation_plot"), width = 8),
    box(selectInput(inputId = "library1",label = "Primeira biblioteca",
        choices = libraries[-1]) , width = 4)),
    box(selectInput(
      inputId = "year1",
      label = "Ano analisado",
      choices = seq(2009, 2019)),
      width = 4)
  )
server <- function(input, output){
  output$correlation_plot <- renderPlot({
    plot(dataset$python, dataset$spacy, ylab = "python", xlab = "")
    plot(dataset$python, dataset[[input$library1]], ylab = "python", xlab = "")
  })
}

shinyApp(ui, server)
