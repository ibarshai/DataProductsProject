library(shiny)
data(mtcars)

shinyServer(
  function(input, output) {
    
    # Define regress() as a reactive function that does the following:
    #   - If any variables have been selected, paste together the function f
    #   - If any interactions have been selected, add them to function f
    #   - Use the lm function to create a linear model using function f
    #   - return the function, linear model and summary of linear model
    
    regress = reactive({
      
      # If any variables have been selected, paste together the function f
      if(length(input$checkvars==0)) 
        f = paste0("mpg~",paste(input$checkvars,collapse="+"))
      else                    
        f = "No formula selected"
      
      # If any interactions have been selected, add them to function f
      if(length(input$inter1==0))
        f = paste0(f, paste0("+", paste(input$inter1, collapse="*")))
      if(length(input$inter2==0))
        f = paste0(f, paste0("+", paste(input$inter2, collapse="*")))
      
      # Use the lm function to create a linear model using function f and return
      if(f!="No formula selected"){
        fit = lm(as.formula(f),data=mtcars)
        fitsumm = summary(fit)
        return(list(f=f, fit=fit, fitsumm=fitsumm))
      }
        
      return(list(f=f))
    })
      
    output$f <- renderText({regress()$f})
    
    output$theplot <- renderPlot({
      if(regress()$f!="No formula selected") plot(regress()$fit)
      else plot.new()})
    #output$theplot <- renderPlot(regress()$theplot)
    output$fitcoefs <- renderPrint({coef(regress()$fitsumm)})
    output$fitRsq <- renderPrint({regress()$fitsumm$r.squared})
  }
)