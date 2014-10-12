# server.R

library(lubridate)
library(ggplot2)
library(shiny)

tripsfile = 'data/trips.csv'
trips <- read.csv(tripsfile, stringsAsFactors = FALSE)
# Note, I know I didn't leave the Easern time zone during this period 
# with this car.
tz = 'America/New_York'
trips$Trip.Started.At <- ymd_hms(trips$Trip.Started.At, tz = tz)
trips$Trip.Ended.At <- ymd_hms(trips$Trip.Ended.At, tz = tz)
trips$day <- weekdays(trips$Trip.Started.At)
trips$day.type <- 'Weekday'
trips$day.type[trips$day %in% c('Saturday', 'Sunday')] <- 'Weekend'

shinyServer(

    function(input, output) {
        output$dayType <- renderPrint({input$dayType})
        plotTrips <- reactive({subset(trips, day.type %in% input$dayType)})
        output$newHist <- renderPlot({
            hist(plotTrips()$trip.minutes, 
                 xlab = 'trip time (minutes)', 
                 main = 'Histogram', 
                 breaks = input$nbins)
        })
    })

