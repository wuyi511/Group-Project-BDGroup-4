# This will show the table which allows the user to
# choose which state and county's data to especially look for.

library(ggplot2)
library(shiny)

jobs <- read.csv("Jobs.csv")
function(input, output) {
    
    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        data <- jobs
        if (input$state != "All") {
            data <- data[data$State == input$state,]
        }
        if (input$county != "All") {
            data <- data[data$County == input$county,]
        }
        data
    }))
    
}
