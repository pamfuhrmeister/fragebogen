#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinysurveys)

#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

questionnaire <- read.csv("questionnaire.csv", sep = ";")

ui <- shiny::fluidPage(
  shinysurveys::surveyOutput(df = questionnaire,
               survey_title = "Fragebogen zum Experiment",
               survey_description = "Bitte beantworten Sie die folgenden Fragen.",
               theme = "#22133a")
)

server <- function(input, output, session) {
  shinysurveys::renderSurvey()
  
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Vielen Dank!"
    ))
    
    response_data <- getSurveyData(custom_id = input$subject_id)
    write.csv(response_data, paste0(input$subject_id, "_response_data.csv"))
  })
  
}

shiny::shinyApp(ui = ui, server = server)
