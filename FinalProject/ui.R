#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyverse)
library(tidyr)

jobL <- 
    jobs %>% 
    pivot_longer(contains("Change"), 
                names_to = "ChangePeriod",
                values_to = "Percent") %>% 
    group_by(State) %>% 
    mutate(ChangePeriod = sub("PctEmpChange", "PctEmpChange_", ChangePeriod)) %>% 
    separate(ChangePeriod, into = c("PctEmpChange", "Period"),convert = TRUE)

jobYear <- 
    jobs %>% 
    pivot_longer(contains("UnempRate"),
                 names_to = "UnRateYear",
                 values_to = "UnempRate") %>% 
    mutate(UnRateYear = sub("UnempRate", "UnRate_", UnRateYear)) %>% 
    separate(UnRateYear, into = c("UnRate", "Year")) %>% 
    select(State,County,Year,UnempRate) %>% 
    group_by(State) %>% 
    arrange(Year)


shinyUI(fluidPage(

    # Application title
    titlePanel("US Unemployment Rate Varies by State"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "n",
                        label = "# dots",
                        min = 1, 
                        max = 10000,
                        value = 100),
            radioButtons("color", label = "Dot color",
                         choices = list("Red" = "red",
                                        "Blue" = "blue",
                                        "Brown" = "brown"),
                         selected = "red"),
            uiOutput("state")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("scatterplot")
        )
    )
))
