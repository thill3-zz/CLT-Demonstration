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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        set.seed(20190615)
                noSim <- reactive({input$means})
                meanOf <- reactive({input$numInMeans})
                lambda <- reactive({input$lambda})
                iColor <- reactive({input$colorNum})
                values <- reactive({rexp(n = meanOf() * noSim(), rate = lambda())})
                
                iTitle1 <- reactive({
                                paste(
                                        'Histogram of',
                                        length(values()),
                                        'Exponential Random Variables'
                                )
                })
                
                iTitle2 <- reactive ({
                                paste(
                                        'Histogram of',
                                        noSim(),
                                        'Means of',
                                        meanOf(),
                                        'Exponential Random Variables Each'
                                )
                })
                matVal <- reactive ({
                        matrix(
                                data = values(),
                                nrow = noSim(),
                                ncol = meanOf()
                        )
                })
                
                means <- reactive({apply(matVal(), MARGIN = 1, mean)})
                
        output$plot1 <- renderPlot({
                qplot(
                        values(),
                        geom = "histogram",
                        binwidth = input$dataWidth,
                        fill = I(iColor()),
                        col = I("black"),
                        xlab = 'Value',
                        main = iTitle1(),
                        xlim=(c(min(values()), max(values())))
                )
        }) #EndOutput$plot1
        
        output$g2 <- renderPlot ({
                qplot(
                        means(),
                        geom = "histogram",
                        binwidth = input$meansWidth,
                        fill = I(iColor()),
                        col = I("black"),
                        xlab = 'Value',
                        main = iTitle2()
                )
        }) #EndOutput$g2
        output$help <- renderUI({HTML("The Central Limit Theorem states that if a 
                set of values are generated from any probability distribution, 
                the mean of those random values is computed, and this process is
                repeated many times then
                 the resulting set of means is approximately normally distributed. This 
                is true regardless of the distribution from which the original 
                values were taken. <br/>
                This app is intended to demonstrate the 
                Central Limit Theorem using values generated from the 
                exponential distribution. The exponential distribution requires 
                a specified parameter lambda to define the specific (not general)
                form of its probability distribution. The exponential distribution is a 
                continuous distribution. The mean (average) value for an exponential probability 
                distribution with a particular lambda value 
                (average) is 1/lambda, so the mean rises as lambda decreases
                (and the mean drops as lambda increases). <br/>
                In this app you can adjust the number of values used to calculate each mean,
                and you may choose how many means to view in the plot. The lambda value is 
                adjustable, and the histogram bin widths can be changed in 
                order to get a better sense of either distribution. Additionally,
                 you are welcome to change the color of the plot in order to 
                make it more appealing to you.")})
        output$dataText <- renderText({'                qplot(
                        values(),
                        geom = "histogram",
                        binwidth = input$dataWidth,
                        fill = I(iColor()),
                        col = I("black"),
                        xlab = \'Value\',
                        main = iTitle1(),
                        xlim=(c(min(values()), max(values())))
                )'})
        output$meansText <- renderText({'                qplot(
                        means(),
                        geom = "histogram",
                        binwidth = input$meansWidth,
                        fill = I(iColor()),
                        col = I("black"),
                        xlab = \'Value\',
                        main = iTitle2()
                )'})
} #endFunction
) #EndShinyServer