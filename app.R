library(shiny)

ui <- fluidPage(
  titlePanel("Iris Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "species",
        "Choose species:",
        choices = unique(iris$Species)
      )
    ),
    
    mainPanel(
      plotOutput("sepal_plot"),
      plotOutput("petal_plot")
    )
  )
)

server <- function(input, output, session) {
  
  output$sepal_plot <- renderPlot({
    data <- iris[iris$Species == input$species, ]
    
    plot(
      data$Sepal.Length,
      data$Sepal.Width,
      xlab = "Sepal Length",
      ylab = "Sepal Width",
      main = paste("Sepal Measurements -", input$species)
    )
  })
  
  output$petal_plot <- renderPlot({
    data <- iris[iris$Species == input$species, ]
    
    plot(
      data$Petal.Length,
      data$Petal.Width,
      xlab = "Petal Length",
      ylab = "Petal Width",
      main = paste("Petal Measurements -", input$species)
    )
  })
}

shinyApp(ui, server)
