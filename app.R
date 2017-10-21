library(shiny)
df<-read.csv("mapdata.csv")

ui<-fluidPage(
  sliderInput(inputId = "year",
              label = "Choose a Year",
              value = 2005, min = 1999, max = 2010),
  plotOutput("yr")
)
server<- function(input, output) {
  output$yr <-  renderPlot({
    title <- "Histogram of County TFPs"
    hist(unlist(df[paste0("TFPYRM", input$year)]), main = title)
  })
}
shinyApp(ui = ui, server = server)
