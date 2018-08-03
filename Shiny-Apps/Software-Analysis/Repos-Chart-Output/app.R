library(lubridate)
library(shiny)
library(stringr)

# setwd('~/Github-Public/Shiny-Exemplar/Shiny-Apps/Software-Analysis/')
files <- read.csv('files.csv', header = TRUE)
files$Filename <- str_sub(files$Filename, end = 25)
files$Filetype <- as.character(files$Filetype)

repo.choices <- list("cfi-js","vsr-bookshelf","vsrbookshelf-e2e-testing","vsr-bookshelf-frontend",
                     "vsr-builder","vsrbuilder-e2e-testing","vsr-builder-frontend","vsr-common",
                     "vsr-offline-android","vsr-offline-core","vsr-offline-ios","vsr-offline-mac",
                     "vsr-offline-windows","vsr-reader")

# User interface ----
ui <- fluidPage(
  titlePanel("VSR Software Project Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("repo", 
                  label = "Choose a repository:",
                  choices = repo.choices,
                  selected = "cfi-js")
    ),
    mainPanel(
      # textOutput("text"),
      plotOutput("plot")
    )
  )
)

# Server logic ----
server <- function(input, output) {
  # output$text <- renderText(sprintf("start: %s  end: %s", input$date_range[1], input$date_range[2]))
  output$plot <- renderPlot({
    tbl <- table(files$Filetype[files$Repository == input$repo])
    tbl <- tbl[tbl > 3]
    pie(tbl, main = "Number of files of a given filetype (w/ n < 3 removed)")
  })
}

# Run app ----
shinyApp(ui, server)