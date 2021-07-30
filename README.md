# AirQuality
Shiny app created to quickly visualize summer air quality data collected in New York. The data comes from data provided in R throught the dataset library (library("datasets")). This App is simple and user friendly. The only UI capability included is a dropdown menu of the different vairables (columns) from the data. The resulting app creates a barplot for trends within each measurement. The user can select the variable, and the barplot automatically updates to the new variable. This is very helpful as it quickly turns raw data into a visualization, which allows the user to understand the varaible results more effectively.   

Below is the code and comments on the different aspects, marked with # at the start of the line. 


library(datasets)
data(airquality)
data.frame(airquality)

#Below is the UI portion of the ShinyApp. This is where we set up our user panel and customize the inputs (slide bars, input boxes, etc.). The selection input "type" is used 
#in the server portion further below for reference


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

#Below is the server portion of the ShinyApp. This is where we set up the actual input and output in the app (the visual). Using different packages and function this can be 
#customized to create almost anything the creator desires. I have a barplot selected, but also have a scatter.smooth commented out, which can be flipped with barplot depending on what the user wants. 

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

#ShinyApp function actually runs the app, based on the UI and server we created above 

shinyApp(ua4, serv1)
