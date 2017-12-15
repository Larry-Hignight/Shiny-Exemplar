library(shiny)

x <- read.csv('data/tenant.csv', header = TRUE)

# User interface ----
ui <- fluidPage(
  titlePanel("Tenant Visualization"),
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with information from the 2010 US Census."),
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