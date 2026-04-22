library(shiny)
library(ggplot2)
library(readr)

# Read data
hdr <- read.csv("HDR23-24_subset.csv", fileEncoding = "Latin1")

# Variables allowed in the app
numeric_vars <- c(
  "hdi_2022", "le_2022", "mys_2022", "gnipc_2022",
  "ineq_le_2022", "ineq_edu_2022", "ineq_inc_2022", "co2_prod_2022"
)

# Force selected variables to numeric
hdr[numeric_vars] <- lapply(hdr[numeric_vars], function(x) as.numeric(as.character(x)))

ui <- fluidPage(
  titlePanel("HDR Data Explorer"),
  
  tabsetPanel(
    tabPanel(
      "Explore",
      br(),
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "xvar",
            label = "Choose X-axis variable:",
            choices = numeric_vars,
            selected = "mys_2022"
          ),
          
          selectInput(
            inputId = "yvar",
            label = "Choose Y-axis variable:",
            choices = numeric_vars,
            selected = "le_2022"
          ),
          
          actionButton(
            inputId = "run_plot",
            label = "Run Analysis"
          ),
          
          hr(),
          p("Use this tab to explore the relationship between two human development indicators."),
          p("Select one variable for the X-axis and one for the Y-axis, then click 'Run Analysis' to update the plot and summary."),
          p("The app displays a scatter plot, a fitted linear regression line, and a short statistical interpretation based on complete-case data.")
        ),
        
        mainPanel(
          plotOutput("scatterplot"),
          br(),
          verbatimTextOutput("summary_text")
        )
      )
    ),
    
    tabPanel(
      "About",
      br(),
      h3("App Goal"),
      p("This app explores relationships between life expectancy and selected human development indicators across countries."),
      
      h3("Motivating Question"),
      p("How is life expectancy associated with education, income, inequality, and other development indicators?"),
      
      h3("Author"),
      p('Mengzhi "Grace" Yuan'),
      
      h3("Data Source"),
      p("HDR23-24_subset.csv"),
      
      h3("Methods"),
      p("For the selected pair of variables, the app displays a scatter plot with a fitted linear regression line and 95% confidence band. It also reports the Pearson correlation, p-value, and complete-case sample size as a simple summary of linear association."),
      
      h3("GitHub Repository"),
      p("https://github.com/grace912-yuan/6270-cp07-shiny"),
      
      h3("AI Disclosure"),
      p("This app was developed with coding support from ChatGPT. All final decisions, testing, and interpretation were reviewed by the author.")
    )
  )
)

server <- function(input, output, session) {
  
  plot_data <- eventReactive(input$run_plot, {
    selected_data <- hdr[, c(input$xvar, input$yvar)]
    selected_data <- na.omit(selected_data)
    
    names(selected_data) <- c("x", "y")
    
    selected_data$x <- as.numeric(selected_data$x)
    selected_data$y <- as.numeric(selected_data$y)
    
    selected_data
  })
  
  output$scatterplot <- renderPlot({
    req(plot_data())
    req(nrow(plot_data()) > 1)
    
    ggplot(plot_data(), aes(x = x, y = y)) +
      geom_point(alpha = 0.7, size = 2) +
      geom_smooth(method = "lm", se = TRUE) +
      labs(
        title = paste("Relationship between", input$yvar, "and", input$xvar),
        subtitle = paste("Complete cases only | n =", nrow(plot_data())),
        x = input$xvar,
        y = input$yvar,
        caption = "Source: HDR23-24_subset.csv"
      ) +
      theme_minimal(base_size = 14)
  })
  
  output$summary_text <- renderText({
    req(plot_data())
    req(nrow(plot_data()) > 2)
    
    x <- plot_data()$x
    y <- plot_data()$y
    
    req(is.numeric(x), is.numeric(y))
    
    cor_test <- cor.test(x, y)
    r_value <- unname(cor_test$estimate)
    
    direction <- if (r_value > 0) {
      "a positive"
    } else if (r_value < 0) {
      "a negative"
    } else {
      "no"
    }
    
    strength <- if (abs(r_value) >= 0.7) {
      "strong"
    } else if (abs(r_value) >= 0.4) {
      "moderate"
    } else {
      "weak"
    }
    
    paste0(
      "Pearson correlation: ", round(r_value, 3),
      "\nP-value: ", signif(cor_test$p.value, 3),
      "\nSample size: ", nrow(plot_data()),
      "\nInterpretation: The selected variables show ", direction, " ", strength,
      " linear association in the complete-case data."
    )
  })
}

shinyApp(ui = ui, server = server)

shinyApp(ui = ui, server = server)