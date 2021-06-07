
library(ggplot2)

# The stakeholder likely to be someone considering a job in specific
# area, State, and County.
jobs <- read.csv("Jobs.csv")
fluidPage(
    titlePanel("Data Table for Jobs"),
    
    # Create a new Row in the UI for selectInputs
    fluidRow(
        column(4,
               selectInput("state",
                           "State:",
                           c("All",
                             unique(as.character(jobs$State))))
        ),
        column(4,
               selectInput("county",
                           "County:",
                           c("All",
                             unique(as.character(jobs$County))))
        )
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table")
)
