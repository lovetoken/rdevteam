library(shiny)
library(rdevteam)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Naver 연관검색어 분석(by R dev. team)"),
   
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
   
   output$test <- renderText({
      
     first <- naverRelation1(input$text)
     return(first)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

