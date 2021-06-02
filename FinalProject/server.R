#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

jobs <- read.csv("Jobs.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    posi <- reactive({
        if(is.null(input$states)){
            jobYear %>% 
                sample_n(input$n,replace = TRUE)
        }else{
            jobYear %>% 
                filter(State %in% input$states) %>% 
                sample_n(input$n, replace = TRUE)
        }
    })
    
    output$scatterplot <- renderPlot({
        ggplot(posi(),aes(Year,UnempRate))+
            geom_point(col = input$color)+
            ggtitle("US Unmployment Rate Varies Between States")
    })
    # choose specific state to show the Employment Rate change
    output$state <- renderUI({
        checkboxGroupInput("states", label = "Unemployment Rate Change in Percentage",
                           choices = unique(jobYear$State))
    })
})
