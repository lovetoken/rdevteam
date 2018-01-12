#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Naver 연관검색어 분석"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         textInput("text", label = ("Text input"), value = "Enter the keyword")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         textOutput("test")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$test <- renderPrint({
      
     print(input$test)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

