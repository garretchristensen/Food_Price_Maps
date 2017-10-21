library(shiny)
library(ggcounty)
library(sp)
library(ggplot2)
library(maptools)
library(rgeos)

df<-read.csv("mapdata.csv")
# get the US counties map (lower 48)
us <- ggcounty.us()

ui<-fluidPage(
  sliderInput(inputId = "year",
              label = "Choose a Year",
              value = 2005, min = 1999, max = 2010, step = 1, sep = ""),
  plotOutput("yr"),
  plotOutput("map")
)
server<- function(input, output) {
  output$yr <-  renderPlot({
    title <- "Histogram of County TFPs"
    hist(unlist(df[paste0("TFPYRM", input$year)]), main = title,
         xlab = "Dollar Price of Weekly TFP, Family of 4")
  })
  
  output$map <- renderPlot({
    df$brk <- cut(unlist(df[paste0("TFPYRM", input$year)]),
                  breaks=c(0, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250),
                  labels=c("0-140", "-149", "-159", "-169", "-179", "-189",
                           "-199", "-209", "-219", "-229", "-239", "-250"),
                  include.lowest=TRUE)

    # start the plot with our base map
    gg <- us$g

    #add a new geom with our population (choropleth)
    gg <- gg + geom_map(data=df, map=us$map,
                        aes(map_id=FIPS, fill=brk),
                        color="white", size=0.25)  + scale_fill_brewer(palette = "Greens" )
    gg
  })
}
shinyApp(ui = ui, server = server)
