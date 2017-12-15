library(shiny)

bookmarks <- read.csv('data/user_book_bookmark.csv', header = TRUE)
highlights <- read.csv('data/user_book_highlight.csv', header = TRUE)

# User interface ----
ui <- fluidPage(
  titlePanel("Select Box & Checkbox Example"),
  sidebarLayout(
    sidebarPanel(
      helpText("This Shiny app demonstrates how to use the select box and checkbox widgets."),
      checkboxGroupInput(inputId = "checkbox", 
                         label = h3("Display information about"), 
                         choices = list("Bookmarks" = 1, "Highlights" = 2), 
                         selected = 1),
      selectInput(inputId = "var", 
                  label = "Group information by",
                  choices = c("Book", "User"), 
                  selected = "Book")
    ),
    mainPanel(plotOutput("plot"))
  )
)

# Server logic ----
server <- function(input, output) {
  output$plot <- renderPlot({
    if (length(input$checkbox) == 0) {
      # Not supported at this time
    } else if (length(input$checkbox) == 2) {
      switch(input$var, 
             "Book" = plot(table(c(bookmarks$book_id, highlights$book_id)),
                           main = 'Bookmarks & Highlights by Book', 
                           xlab = 'Book ID', 
                           ylab = 'Number of Bookmarks + Highlights'),
             "User" = plot(table(table(c(bookmarks$user_id, highlights$user_id))),
                           main = 'Bookmarks & Highlights by User',
                           xlab = 'Number of Bookmarks + Highlights', 
                           ylab = 'Number of Users'))
    } else if (input$checkbox == 1) {
      switch(input$var, 
             "Book" = plot(table(bookmarks$book_id), main = 'Bookmarks by Book', 
                           xlab = 'Book ID', ylab = 'Number of Bookmarks'),
             "User" = plot(table(table(bookmarks$user_id)), main = 'Bookmarks by User',
                           xlab = 'Number of Bookmarks', ylab = 'Number of Users'))
    } else if (input$checkbox == 2) {
      switch(input$var, 
             "Book" = plot(table(highlights$book_id), main = 'Highlights by Book', 
                           xlab = 'Book ID', ylab = 'Number of Highlights'),
             "User" = plot(table(table(highlights$user_id)), main = 'Highlights by User',
                           xlab = 'Number of Highlights', ylab = 'Number of Users'))
    } 
  })
}

# Run app ----
shinyApp(ui, server)
