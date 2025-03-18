# 📊 Shiny Sales Dashboard

Welcome to the **Shiny Sales Dashboard**, an interactive web application built with R and Shiny. This app provides insightful visualizations of sales data while ensuring a secure login system for authorized users.

## 🚀 Features
- **🔐 Secure Login System**: Basic authentication with username and password validation.
- **📊 Data Visualizations**: Three interactive sales-related plots:
  - **Sales by Product and Season (Bar Chart)**
  - **Sales Distribution by Season (Box Plot)**
  - **Heatmap of Sales by Date and Product**
- **🎨 Stylish UI**: Custom CSS for a professional look and feel.
- **📅 Randomized Sales Data**: Simulated sales dataset for demonstration purposes.

## 🛠 Installation

### Prerequisites
Ensure you have R and the required packages installed:
```r
install.packages(c("shiny", "ggplot2", "dplyr", "lubridate"))
```

### Running the App
1. Clone this repository or download the files.
2. Open R or RStudio and run the following command:
   ```r
   shiny::runApp("path/to/app.R")
   ```

## 🔑 Login Credentials
The app includes a basic authentication system with the following default credentials:
- **Username**: `user`
- **Password**: `pass`

> ⚠️ **Note:** For security reasons, it is recommended to implement a more secure authentication mechanism in production.

## 📈 Dashboard Visualizations
Once logged in, users can explore the following charts:
1. **Sales by Product and Season**
   - A grouped bar chart showing total sales for each product across different seasons.

2. **Sales Distribution by Season**
   - A box plot representing the spread of sales data for each season.

3. **Heatmap of Sales by Date and Product**
   - A heatmap visualizing sales trends over time for different products.

## 🛡 Security Considerations
- Credentials are currently stored as plaintext (Not recommended for production).
- Future improvements could include hashing passwords and integrating a user authentication system.
- Consider implementing **rate-limiting** to prevent brute-force attacks.

## 🎯 Future Enhancements
- ✅ Allow users to upload their own sales data.
- ✅ Improve heatmap readability with aggregation techniques.
- ✅ Implement a secure database-backed authentication system.
- ✅ Add a filtering system for more granular analysis.


