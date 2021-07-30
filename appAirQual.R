library(datasets)
data(airquality)
data.frame(airquality)
ua4 <- fluidPage(
    titlePanel("New York Summer Air Quality"), 
    sidebarLayout(
        sidebarPanel(
            selectInput("type", "Air Quality Effect Measure:", 
                        choices = colnames(airquality)
                        ),
            hr(),
            helpText("Air quality records May-Sep for New York. Ozone is for ozone parts, Solar.R is the solar rediation, wind is wind speed, and Temp is the temperature recordings. Source: New York State Dep. of Conservation")
        ),
        mainPanel(
            plotOutput("airPlot")
        )
    )
)
serv1 <- function(input, output) {
    output$airPlot <- renderPlot({
        barplot(airquality[,input$type],
                col = 2,
                main="Air Quality Ratings",
                ylab="Air Quality",
                xlab="Effect Measure")
        #scatter.smooth(airquality[,input$type],
         #    col = 2, 
          #   main=input$type)
    })
}

shinyApp(ua4, serv1)
