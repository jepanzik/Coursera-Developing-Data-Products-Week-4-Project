#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("New York Air Quality Measurements"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            checkboxInput("may", "May", TRUE),
            checkboxInput("june", "June", TRUE),
            checkboxInput("july", "July", TRUE),
            checkboxInput("aug", "August", TRUE),
            checkboxInput("sept", "September", TRUE),
            submitButton("Submit")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h4("Impact of Ozone on Temperature by Month"),
            plotOutput("plot1"),
            h5("For every 1 ppb of ozone, the Fahrenheit temperature increases by:"),
            textOutput("modelSlope")
            
        )
    )
))
