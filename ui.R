# ui.R

library(shiny)
first.date <- '2014-03-06'
last.date <- '2014-10-08'

shinyUI(pageWithSidebar(
    headerPanel("Exploring trip data"),
    sidebarPanel(
        dateRangeInput("dates", 
                       label = h4("Date range"), 
                       start = first.date, end = last.date, 
                       min = first.date, max = last.date), 
        checkboxGroupInput("dayType", 
                           label = h4('Day type'), 
                           choices = list("Weekday", "Weekend"),
                           selected = c('Weekday', 'Weekend')), 
        numericInput("nbins", label = h4("Number of bins"), min = 5, 
                    max = 25, value = 20, step = 5)
    ),
    mainPanel(
        verbatimTextOutput("dayType"), 
        plotOutput('newHist')
    )
))