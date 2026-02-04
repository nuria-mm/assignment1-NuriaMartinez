library(shiny)

structures <- list(
  Sepal = list(
    x = "Sepal.Length",
    y = "Sepal.Width",
    xlab = "Sepal Length",
    ylab = "Sepal Width",
    title = "Sepal Measurements"
  ),
  Petal = list(
    x = "Petal.Length",
    y = "Petal.Width",
    xlab = "Petal Length",
    ylab = "Petal Width",
    title = "Petal Measurements"
  )
)

ui <- fluidPage(
  titlePanel("Iris Explorer"),

  sidebarLayout(
    sidebarPanel(
      selectInput(
        "species",
        "Choose species:",
        choices = unique(iris$Species),
        selected = unique(iris$Species)[1]
      ),

      radioButtons(
        "structure",
        "Choose flower structure:",
        choices = names(structures),
        selected = "Sepal"
      )
    ),

    mainPanel(
      plotOutput("plot"),
      hr(),
      tableOutput("summary_table")
    )
  )
)

server <- function(input, output, session) {

  output$plot <- renderPlot({
    data <- iris[iris$Species == input$species, ]
    cfg <- structures[[input$structure]]

    plot(
      data[[cfg$x]],
      data[[cfg$y]],
      xlab = cfg$xlab,
      ylab = cfg$ylab,
      main = paste(cfg$title, "-", input$species)
    )
  })

  output$summary_table <- renderTable({
    data <- iris[iris$Species == input$species, ]
    cfg <- structures[[input$structure]]

    x <- data[[cfg$x]]
    y <- data[[cfg$y]]

    summary <- data.frame(
      statistic = c("Count", "Mean", "Std. Dev."),
      length = c(length(x), mean(x), sd(x)),
      width  = c(length(y), mean(y), sd(y))
    )

    summary
  }, digits = 3)
}

shinyApp(ui, server)
