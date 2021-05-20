#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(plotly)
library(leaflet)
library(htmltools)

all_data = read.csv("All_location_data_cut.csv")
all_data$X = NULL

#define server input output function
server = function(input,output){

    
#output for TAB 1
output$mymap_non_scot = renderLeaflet({
        mapping_data = all_data[which(all_data$Area == input$selected_location_non_scot),]
        mapping_data = na.omit(mapping_data)
        mapping_data = mapping_data[which(mapping_data$BusinessType == input$selected_type_non_scot),]
        mapping_data = mapping_data[which(mapping_data$Rating == input$selected_rating_non_scot),]
        map = leaflet()
        map = addTiles(map)
        map = addMarkers(map, lng = ~Longitude, lat = ~Latitude, popup=~htmlEscape(BusinessName), data = mapping_data)
        map
        })
    
#Output for TAB 2    
    output$mymap_scot = renderLeaflet({
        mapping_data = all_data[which(all_data$Area == input$selected_location_scot),]
        mapping_data = na.omit(mapping_data)
        mapping_data = mapping_data[which(mapping_data$BusinessType == input$selected_type_scot),]
        mapping_data = mapping_data[which(mapping_data$Rating == input$selected_rating_scot),]
        map = leaflet()
        map = addTiles(map)
        map = addMarkers(map, lng = ~Longitude, lat = ~Latitude, popup=~htmlEscape(BusinessName), data = mapping_data)
        map
        })
    
    
#Output 1 for Tab 3     
    output$rating_by_area <- renderPlotly({
        area_data = all_data[which(all_data$Area == input$selected_area_plot),]
        area_data$Rating = as.factor(area_data$Rating)
        this_plot = ggplot(area_data, aes(Rating))+geom_bar()+labs(x="", y = "", title = paste("Total Ratings in",gsub(".csv","",input$selected_area_plot)))
        ggplotly(this_plot)
    })

#Output 2 for Tab 3        
    output$type_by_area <- renderPlotly({
        area_data = all_data[which(all_data$Area == input$selected_area_plot),]
        area_data$BusinessType = as.factor(area_data$BusinessType)
        this_plot = ggplot(area_data, aes(BusinessType))+geom_bar() +labs(x="", y = "", title = paste("Types of business in",gsub(".csv","",input$selected_area_plot))) + theme(axis.text.x = element_text(angle = 90))
        ggplotly(this_plot)
    })

#Output for Tab 4        
    output$All_data = renderDataTable(all_data)
    

    
    
}