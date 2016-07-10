library(shiny)
library(UsingR)
library(ggplot2)

# Import diamond dataset for Illustrating prediction with regression.
data(diamond)

# Lets estimate an expected dollar value increase in price for every carat 
# increase in mass of diamond.
fit <- lm(price ~ carat, data = diamond)

computePrice <- function(desiredCaretVal) {
  (coef(fit)[1] + coef(fit)[2] * desiredCaretVal)
}

shinyServer(
  function(input, output) {
    # Display all the inputs that is sent by the client.
    output$ocaratSlider <- renderPrint(input$caratSlider)
    output$ocaratCombo <- renderPrint(input$caratCombo)
    output$odisplayPlot <- renderPrint(input$displayPlot)
    output$odate <- renderPrint(input$date)
    
    # Now, let’s predicting the price of a diamond. This should be as easy as 
    # just evaluating the fitted line at the price we want to.
    output$osliderPrice <- renderPrint({unname(computePrice(input$caratSlider), force = FALSE)})
    output$oboxPrice <- renderPrint({unname(computePrice(input$caratCombo), force = FALSE)})
    
    # Render the plot showing diamond data with mass by carats.
    output$newRegrPlot <- renderPlot({
      if (is.null(input$displayPlot)) {return()}
      g = ggplot(diamond, aes(x = carat, y = price))
      g = g + xlab("Mass (carats)")
      g = g + ylab("Price (SIN $)")
      g = g + geom_point(size = 7, colour = "black", alpha=0.5)
      g = g + geom_point(size = 5, colour = "blue", alpha=0.2)
      g = g + geom_smooth(method = "lm", colour = "black")
      g = g + geom_vline(xintercept = input$caratSlider, colour="red")
      g = g + geom_hline(yintercept = computePrice(input$caratSlider), colour="red")
      g = g + geom_vline(xintercept = input$caratCombo, colour="darkblue")
      g = g + geom_hline(yintercept = computePrice(input$caratCombo), colour="darkblue")
      g
    })
  }
)
