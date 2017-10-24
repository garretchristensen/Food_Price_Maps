library(shiny)
library(choroplethr)
library(choroplethrMaps)
# library(Rcpp)
# library(dplyr)
# library(rlang)
# library(scales)
# library(tibble)
#library(ggcounty)
#library(sp)
library(ggplot2)
#library(maptools)
#library(rgeos)
#library(mapproj)

df<-read.csv("mapdata.csv")
df$region <- df$FIPS
data(continental_us_states)
# get the US counties map (lower 48)
#us <- ggcounty.us()

ui<-fluidPage(
  includeMarkdown("include.md"),
  fluidRow(align = "center", sliderInput(inputId = "year",
              label = "Choose a Year",
              value = 2005, min = 1999, max = 2010, step = 1, sep = "")),
  plotOutput("map"),
  fluidRow(
    column(6, align = "center", tags$b("Histogram of All US Counties TFP Price"),
           fluidRow(plotOutput("yr"))),
    column(6, selectInput(inputId = "state", label = "Choose a state to zoom in on:",
                                            list (`states`=c("Alabama",
                                                             "Arizona",
                                                             "Arkansas",
                                                             "California",
                                                             "Colorado",
                                                             "Connecticut",
                                                             "Delaware",
                                                             "Florida",
                                                             "Georgia",
                                                             "Idaho",
                                                             "Illinois",
                                                             "Indiana",
                                                             "Iowa",
                                                             "Kansas",
                                                             "Kentucky",
                                                             "Louisiana",
                                                             "Maine",
                                                             "Maryland",
                                                             "Massachusetts",
                                                             "Michigan",
                                                             "Minnesota",
                                                             "Mississippi",
                                                             "Missouri",
                                                             "Montana",
                                                             "Nebraska",
                                                             "Nevada",
                                                             "New Hampshire",
                                                             "New Jersey",
                                                             "New Mexico",
                                                             "New York",
                                                             "North Carolina",
                                                             "North Dakota",
                                                             "Ohio",
                                                             "Oklahoma",
                                                             "Oregon",
                                                             "Pennsylvania",
                                                             "Rhode Island",
                                                             "South Carolina",
                                                             "South Dakota",
                                                             "Tennessee",
                                                             "Texas",
                                                             "Utah",
                                                             "Vermont",
                                                             "Virginia",
                                                             "Washington",
                                                             "West Virginia",
                                                             "Wisconsin",
                                                             "Wyoming"))),
     fluidRow(plotOutput("statemap"))
    )
  )  
  ) 

server<- function(input, output) {
  output$yr <-  renderPlot({
    title <- ""#Histogram of County TFP Price"
    hist(unlist(df[paste0("TFPYRM", input$year)]), breaks=20, main = title, 
         xlab = "Price of Weekly TFP, Family of 4, 2010 Dollars", xlim=c(146,250))
  })
  
  output$map <- renderPlot({
    df$value <- unlist(df[paste0("TFPYRM", input$year)])
    county_choropleth(df, 
            state_zoom = continental_us_states)
  })
  
  output$statemapyr <- renderText({paste(input$state, input$year, sep =" ")})
  
  output$statemap <- renderPlot({
    df$value <- unlist(df[paste0("TFPYRM", input$year)])
    county_choropleth(df, 
    legend     = "TFP Price",
    #title = paste(input$state, input$year, sep=" "),
    num_colors = 7,
    state_zoom = tolower(input$state),
    reference_map = FALSE) +  scale_fill_brewer(palette=2)
  })
  # output$map <- renderPlot({
  #   df$brk <- cut(unlist(df[paste0("TFPYRM", input$year)]),
  #                 breaks=c(0, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250),
  #                 labels=c("0-140", "-149", "-159", "-169", "-179", "-189",
  #                          "-199", "-209", "-219", "-229", "-239", "-250"),
  #                 include.lowest=TRUE)
  # 
  #   # start the plot with our base map
  #   gg <- us$g
  # 
  #   #add a new geom with our population (choropleth)
  #   gg <- gg + geom_map(data=df, map=us$map,
  #                       aes(map_id=FIPS, fill=brk),
  #                       color="white", size=0.25)  + scale_fill_brewer(palette = "Greens" )
  #   gg
  #})
}
shinyApp(ui = ui, server = server)
