library(shiny)
shinyUI(pageWithSidebar(
  headerPanel('Diamond Price Prediction in Singapore Dollars (SIN $)'),
  sidebarPanel(
    sliderInput('caratSlider', 'Get diamond price from caret slider', value = 0.15, 
                min = 0.15, max = 0.35, step = 0.05),
    numericInput('caratCombo', 'OR, enter desired caret value here', 0.15, 
                 min = 0.15, max = 0.35, step = 0.05),
    checkboxGroupInput('displayPlot', 'Plot diamond data with mass by carats',
                       c('Show Plot' = 1),
                       selected = 1),
    dateInput('date', 'Date:')
  ),
  mainPanel(
    h2('Illustrating prediction with regression.'),
    h4('Carat value using slider '),
    verbatimTextOutput('ocaratSlider'),
    h4('Carat value using drop-down menu'),
    verbatimTextOutput('ocaratCombo'),
    h4('SIN $ price prediction for carat value on slider'),
    verbatimTextOutput('osliderPrice'),
    h4('SIN $ price prediction for carat value in drop-down'),
    verbatimTextOutput('oboxPrice'),    
    plotOutput('newRegrPlot')
  )
))

