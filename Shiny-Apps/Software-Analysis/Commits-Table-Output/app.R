library(lubridate)
library(shiny)
library(stringr)

setwd('~/Github-Public/Shiny-Exemplar/Shiny-Apps/Software-Analysis/')
commits <- read.csv('commits.csv', header = TRUE)
commits <- commits[ , c(2, 4, 1, 3)]

min.date <- ymd("2017-03-01")
max.date <- ymd("2017-12-31")

user.choices <- list("André Morujão", "Araujo, Joana", "Carlos Barbosa", "Joao Moreira", 
                     "Mario Brandao", "Paulo Dias", "Pedro Vieira", "Rui Ferreira", "Rui Pereira")

repo.choices <- list("cfi-js","vsr-bookshelf","vsrbookshelf-e2e-testing","vsr-bookshelf-frontend",
                     "vsr-builder","vsrbuilder-e2e-testing","vsr-builder-frontend","vsr-common",
                     "vsr-offline-android","vsr-offline-core","vsr-offline-ios","vsr-offline-mac",
                     "vsr-offline-windows","vsr-reader")

# User interface ----
ui <- fluidPage(
  titlePanel("VSR Software Project Analysis"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(inputId = "commit_by", 
                         label = h4("Select Users:"),
                         choices = user.choices,
                         selected = user.choices),
      checkboxGroupInput(inputId = "repos", 
                         label = h4("Select Repositories:"),
                         choices = repo.choices,
                         selected = repo.choices),
      dateRangeInput("date_range", label = "Date range", start = min.date, end = max.date,
                     min = min.date, max = max.date, separator = "to")
    ),
    mainPanel(
      # textOutput("text"),
      tableOutput("table")
    )
  )
)

# Server logic ----
server <- function(input, output) {
  # output$text <- renderText(sprintf("start: %s  end: %s", input$date_range[1], input$date_range[2]))
  output$table <- renderTable(commits[commits$User %in% input$commit_by
                                      & commits$Repository %in% input$repos
                                      & ymd_hms(commits$Date) >= ymd(input$date_range[1])
                                      & ymd_hms(commits$Date) <= ymd(input$date_range[2]), ])
}

# Run app ----
shinyApp(ui, server)