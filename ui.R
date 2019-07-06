library(shiny)

shinyUI(pageWithSidebar(
        headerPanel("Central Limit Theorem Demonstration"),
        sidebarPanel(
                numericInput(
                        "means",
                        "How Many Means?",
                        value = 100,
                        min = 1,
                        max = 100,
                        step = 1
                ),
                numericInput(
                        "numInMeans",
                        "Values in each mean: ",
                        value = 25,
                        min = 1,
                        max = 50,
                        step = 1
                ),
                sliderInput('lambda', 'Lambda', .05, 1, value = .2, step = .05),
                sliderInput('dataWidth', 'Bin Width For Data', 1, 6, value = 2, step = .5),
                sliderInput('meansWidth', 'Bin Width for Means', .1, 1, value = .5, step = .1),
                textInput('colorNum', 'Color (word or number between 1 and 657)', value = 652),
                submitButton('Submit')
        ) ,
        #end sidebarPanel
        mainPanel(tabsetPanel(
                type = "tabs",
                tabPanel("Data", textOutput('dataText'), plotOutput("plot1")),  #textOutput('dataText')),
                tabPanel("Means", textOutput('meansText'), plotOutput("g2")),
                tabPanel("Help", htmlOutput("help"))
                
        ))
))

#Consider 
#dashboardsidebar
#dashboarditem
#sidebarMenu
#menuItem
#tabItem