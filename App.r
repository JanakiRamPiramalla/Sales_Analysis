# Load necessary libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)

# Define the valid username and password
valid_username <- "user"
valid_password <- "pass"

# Define the UI
ui <- fluidPage(
  
  # Add custom CSS for styling
  tags$head(
    tags$style(HTML("
      body, html {
        height: 100%;
        margin: 0;
        font-family: Arial, Helvetica, sans-serif;
      }
      
      .bg {
        background-image: url('https://www.w3schools.com/w3images/photographer.jpg');
        height: 100%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
      }
      
      .login-box {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 400px;
        padding: 40px;
        background: rgba(0, 0, 0, 0.6);
        box-shadow: 0 15px 25px rgba(0, 0, 0, 0.5);
        border-radius: 10px;
      }
      
      .login-box h2 {
        margin: 0 0 30px;
        padding: 0;
        color: #fff;
        text-align: center;
      }
      
      .login-box .textbox {
        position: relative;
        margin-bottom: 30px;
      }
      
      .login-box .textbox input {
        width: 100%;
        padding: 10px 0;
        background: none;
        border: none;
        border-bottom: 1px solid #fff;
        outline: none;
        color: #fff;
        font-size: 18px;
      }
      
      .login-box input[type='submit'] {
        width: 100%;
        background: #03a9f4;
        border: none;
        padding: 10px;
        color: white;
        font-size: 18px;
        cursor: pointer;
        border-radius: 5px;
        transition: 0.3s;
      }
      
      .login-box input[type='submit']:hover {
        background: #0288d1;
      }
    "))
  ),
  
  # Conditional panel for login page and dashboard
  uiOutput("ui")
)

# Define the server logic
server <- function(input, output, session) {
  
  # Reactive value to keep track of login status
  logged_in <- reactiveVal(FALSE)
  
  # UI for login page
  output$ui <- renderUI({
    if (!logged_in()) {
      # Show login page
      div(class = "bg",
          div(class = "login-box",
              h2("Login"),
              div(class = "textbox",
                  textInput("username", "Username", placeholder = "Enter Username")
              ),
              div(class = "textbox",
                  passwordInput("password", "Password", placeholder = "Enter Password")
              ),
              actionButton("login", "Login")
          )
      )
    } else {
      # Show the dashboard after login
      fluidPage(
        titlePanel("Sales Dashboard"),
        
        sidebarLayout(
          sidebarPanel(
            h4("Sales Data Visualizations"),
            helpText("Random sales data for products over seasons and time")
          ),
          
          mainPanel(
            tabsetPanel(
              tabPanel("Sales by Product and Season", plotOutput("barPlot")),
              tabPanel("Sales Distribution by Season", plotOutput("boxPlot")),
              tabPanel("Heatmap of Sales by Date and Product", plotOutput("heatmapPlot"))
            )
          )
        )
      )
    }
  })
  
  # Login logic
  observeEvent(input$login, {
    if (input$username == valid_username && input$password == valid_password) {
      logged_in(TRUE)  # Correct login
    } else {
      showModal(modalDialog(
        title = "Invalid Login",
        "The username or password you entered is incorrect.",
        easyClose = TRUE
      ))
    }
  })
  
  # Set seed for reproducibility
  set.seed(123)
  
  # Create a data frame with random sales data
  products <- c("Product A", "Product B", "Product C")
  seasons <- c("Winter", "Spring", "Summer", "Fall")
  sales_data <- data.frame(
    Product = rep(products, each = 100),
    Season = sample(seasons, 300, replace = TRUE),
    Sales = round(runif(300, min = 50, max = 500), 0),
    Date = sample(seq(as.Date('2023-01-01'), as.Date('2023-12-31'), by = "day"), 300, replace = TRUE)
  )
  
  # Plot 1: Sales by Product and Season (Bar Plot)
  output$barPlot <- renderPlot({
    product_season_sales <- sales_data %>%
      group_by(Product, Season) %>%
      summarize(Total_Sales = sum(Sales), .groups = "drop")
    
    ggplot(product_season_sales, aes(x = Product, y = Total_Sales, fill = Season)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Sales by Product and Season", x = "Product", y = "Total Sales") +
      theme_minimal()
  })
  
  # Plot 2: Sales Distribution by Season (Box Plot)
  output$boxPlot <- renderPlot({
    ggplot(sales_data, aes(x = Season, y = Sales, fill = Season)) +
      geom_boxplot() +
      labs(title = "Sales Distribution by Season", x = "Season", y = "Sales") +
      theme_minimal()
  })
  
  # Plot 3: Heatmap of Sales by Date and Product
  output$heatmapPlot <- renderPlot({
    date_product_sales <- sales_data %>%
      group_by(Date, Product) %>%
      summarize(Total_Sales = sum(Sales), .groups = "drop")
    
    ggplot(date_product_sales, aes(x = Date, y = Product, fill = Total_Sales)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") +
      labs(title = "Heatmap of Sales by Date and Product", x = "Date", y = "Product") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)