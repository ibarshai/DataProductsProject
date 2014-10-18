library(shiny)
data(mtcars)

shinyUI(pageWithSidebar(
  # Define header panel
  headerPanel("Covariate Selection for MPG Prediction"),
  
  # Begin description of sidebar panel
  sidebarPanel(
    
    # Selecting single covariates to use in the regression model through checkboxes
    checkboxGroupInput("checkvars", "Select Variables as Single Covariates",
                       c("Cylinders" = "cyl",
                         "Displacement" = "disp",
                         "Horsepower" = "hp",
                         "Rear Axle Ratio" = "drat",
                         "Weight" = "wt",
                         "Gears" = "gear",
                         "Carbs" = "carb",
                         "1/4mi Time" = "qsec")),
    
    # Selecting number of interaction terms to add
    numericInput('interactions', 'Number of interaction terms (max 2)', 
                 0, min = 0, max = 2, step = 1),
    
    # If the number of interaction terms is >0, display selection options
    conditionalPanel(
      condition = "input.interactions > 0",
      checkboxGroupInput("inter1", "Interaction Term 1 - Select Variables",
                       c("Cylinders" = "cyl",
                         "Displacement" = "disp",
                         "Horsepower" = "hp",
                         "Rear Axle Ratio" = "drat",
                         "Weight" = "wt",
                         "Gears" = "gear",
                         "Carbs" = "carb",
                         "1/4mi Time" = "qsec"))),
    
    # If the number of interaction terms is >1, display selection options
    conditionalPanel(
      condition = "input.interactions > 1",
      checkboxGroupInput("inter2", "Interaction Term 2 - Select Variables",
                       c("Cylinders" = "cyl",
                         "Displacement" = "disp",
                         "Horsepower" = "hp",
                         "Rear Axle Ratio" = "drat",
                         "Weight" = "wt",
                         "Gears" = "gear",
                         "Carbs" = "carb",
                         "1/4mi Time" = "qsec")))
  ),
  
  mainPanel(
    h4('Purpose and Use of This Application'),
    p("The purpose of this application is to create an interactive, visual way to select 
      covariates for the linear regression modeling  of MPG as required in the Linear Regression 
      course in this Data Science program using the mtcars dataset."),
    p("To use this app, select the covariates to include in the linear regression model. 
      Then, if you would like to include any interaction terms, select the number of terms
      you would like to include. Then select the interaction terms themselves from checkbox
      groups that appear."),
    
    
    
    # Output the formula
    h4('You entered the formula'),
    textOutput("f"),
    
    # If there is a formula, plot the residuals vs leverage plot of the model
    conditionalPanel(condition = "output.f != 'No formula selected'", 
                     plotOutput('theplot')),
    
    # Output the coefficients of the selected model
    h4('Fit Coefficients'),
    verbatimTextOutput("fitcoefs"),
    
    # Output the R squared value of the selected model
    h4('R Squared Value'),
    verbatimTextOutput("fitRsq")
  )
))
