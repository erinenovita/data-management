#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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



load("drop_list_option.RData")
# load in the drop lists option


ui <- dashboardPage( 
    dashboardHeader(title="Food Hygiene Rating"), 
    
#We specify in the dashboard sidebar: the width of the sidebar and the sidebar menu.    
    dashboardSidebar(  
        width = 270, 
        sidebarMenu(
            
#In the sidebar menu, we specify the differnt menu items along with their name and their icon
            menuItem("Map (England, Wales and N. Ireland)", tabName = "mapping_non_scot", icon = icon('globe-europe')), 
            menuItem("Map (Scotland)", tabName = "mapping_scot", icon = icon('globe-europe')),
            menuItem("Sort By Area", tabName = "plot_area", icon = icon('chart-bar')),
            menuItem("Dataset", tabName = "all_data", icon = icon('table'))
            
        )), 

    dashboardBody(    
        tabItems(
            
#TAB 1
#In the first tab, we have the map including all regions in the UK outside of scotland
            tabItem(tabName = "mapping_non_scot",     

#TAB 1 ROW 1                                        
                    fluidRow( h1("Map (England, Wales and Northern Ireland)") ),
#Header of first tab                    

#TAB 1 ROW 2                   
#Rows of first tab. The first column of the first row is offset to avoid annoying overlapping between dropdown list and map for the user 
                    fluidRow(

                        column(width = 4,
                               offset = 1,
                               selectInput("selected_location_non_scot", label = h3("Select location"),
                                           choices = All_non_Scotland_Area, 
                                           selected = "Adur")
                        ),
                        column(width = 4, 
                               selectInput("selected_rating_non_scot", label = h3("Select Rating"), 
                                           choices = Non_Scotland_Rating, 
                                           selected = "5")
                        ),
                        column(width = 3, 
                               selectInput("selected_type_non_scot", label = h3("Select the type of business"), 
                                           choices = Types_of_Business, 
                                           selected = "Distributors/Transporters")
                        )),
                    
          
#TAB 1 ROW 3         
#The second row includes the map. The map output we specify the output name and the height in the leafleftOutput function                    
                    fluidRow(
                        column(width = 12,
                               leafletOutput("mymap_non_scot", height = 700)
                        )
                    )
                    
            ),

#TAB 2            
#In the second tab, we have the map including all regions in Scotland
            tabItem(tabName = "mapping_scot",
                    
                    
#TAB 2 ROW 1
#Header for Tab 2
                    fluidRow( h1("Map (Scotland)") ),

#TAB 2 ROW 2
#We have in this row 4 columns that are used to filter the map output 
                    fluidRow(
                        
                        column(width = 4,
                               offset = 1,
                               selectInput("selected_location_scot", label = h3("Select location"),
                                           choices = All_Scotland_Area, 
                                           selected = "Aberdeen City")
                        ),
                        column(width = 4, 
                               selectInput("selected_rating_scot", label = h3("Select Rating"), 
                                           choices = Scotland_Rating, 
                                           selected = "Pass")
                        ),
                        column(width = 3, 
                               selectInput("selected_type_scot", label = h3("Select the type of business"), 
                                           choices = Types_of_Business, 
                                           selected = "Distributors/Transporters")
                        )),
                    
#TAB 2 ROW 3
#Map output
                    fluidRow(
                        column(width = 12,
                               leafletOutput("mymap_scot", height = 700)
                        )
                    )
                    
            ),
            
            
            
            
#TAB 3
#This tab include the plots that show by area the number of restaurants in each rating
            tabItem(tabName = "plot_area",
#TAB 3 ROW 1
#Tab header
                    fluidRow(column(width=12, h1("Plot by Area"))),

#TAB 3 ROW 2
#In this row we have the input where the user selects the required city

                    fluidRow(column(width = 6, 
                                    selectInput("selected_area_plot", label = h3("Select the Area"), 
                                                choices = All_Area, 
                                                selected = "Aberdeen City")
                    )),

#TAB 3 ROW 3
#The charts output.
                    fluidRow(column(width = 6,plotlyOutput("type_by_area", height = 1000)),
                             column(width = 6,plotlyOutput("rating_by_area", height = 1000))),
            ),
            
#TAB 4
            tabItem(tabName = "all_data",
#TAB 4 ROW 1 
#Tab header
                    fluidRow(column(width = 12, h1("All the records"))), 

#TAB 4 ROW 2
#Output all the data
                    fluidRow(column(width = 12, dataTableOutput("All_data")))
            )
        )
    )
)