library(shiny)

x <- read.csv('data/tenant.csv', header = TRUE)

# User interface ----
ui <- fluidPage(
  titlePanel("Sliders Widget Example"),
  sidebarLayout(
    sidebarPanel(
      helpText("This Shiny app demonstrates how to use of the slider widget."),
      sliderInput("range", label = "ID Range:", min = 1, max = nrow(x), value = c(1, nrow(x)))
    ),
    mainPanel(tableOutput("table"))
  )
)

# Server logic ----
server <- function(input, output) {
  output$table <- renderTable(x[input$range[1]:input$range[2], ])
}

# Run app ----
shinyApp(ui, server)