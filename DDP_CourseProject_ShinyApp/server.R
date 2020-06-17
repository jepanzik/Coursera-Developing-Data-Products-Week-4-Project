#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    data <- reactive({
        data <- airquality[complete.cases(airquality),]
        if(input$sept==TRUE) {
            data <- data
        } else {
            data <- subset(data, data$Month!=9)
        }
        
        if(input$aug==TRUE) {
            data <- data
        } else {
            data <- subset(data, data$Month!=8)
        }
        
        if(input$july==TRUE) {
            data <- data
        } else {
            data <- subset(data, data$Month!=7)
        }
        
        if(input$june==TRUE) {
            data <- data
        } else {
            data <- subset(data, data$Month!=6)
        }
        
        if(input$may==TRUE) {
            data <- data
        } else {
            data <- subset(data, data$Month!=5)
        }
        
        return(data)
    })
    
    lmFit <- reactive({
        data <- data()
        lmFit <- lm(Temp ~ Ozone, data=data)
        return(lmFit)
    })
    
    output$modelSlope <- renderText({
        lmFit <- lmFit()
        coef(lmFit)[2]
    })
    
    
    output$plot1 <- renderPlot({
        data <- data()
        minY <- floor(min(airquality[complete.cases(airquality),]$Temp)/5)*5
        maxY <- ceiling(max(airquality[complete.cases(airquality),]$Temp)/5)*5
        minX <- 0
        maxX <- ceiling(max(airquality[complete.cases(airquality),]$Ozone)/5)*5
        data$Month <- as.factor(data$Month)
        library(ggplot2)
        g <- ggplot(data=data, aes(x=Ozone, y=Temp))
        g + geom_point(aes(color=Month)) + ylab("Temperature (F)") + xlab("Ozone (ppb)") +
            xlim(minX, maxX) + ylim(minY, maxY) + 
            geom_smooth(method='lm')
    })
})
