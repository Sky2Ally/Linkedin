#Install packages
install.packages("dplyr")
install.packages("tidyverse")
install.packages("VIM")        
install.packages("caret")       
install.packages("randomForest")
install.packages("Metrics")
install.packages("corrplot")
install.packages("ggcorrplot")
install.packages("GGally")
install.packages("e1071")

# Load libraries
library(dplyr)
library(tidyverse)
library(VIM)       
library(caret)      
library(randomForest)
library(corrplot)
library(ggcorrplot)
library(GGally)
library(e1071)


#Load the dataset
forestfires <- read.csv("forestfires.csv")

# Initial data exploration ------------------------------------------------
str(forestfires)  # Check structure
summary(forestfires)  # Summary statistics
head(forestfires)  # View first few rows


## Check for missing values in each column
missing_values <- colSums(is.na(forestfires))
# Display the missing values count per column
print(missing_values)

## Detect duplicates
duplicates <- forestfires[duplicated(forestfires), ]
print(paste("Number of duplicate rows:", nrow(duplicates)))
# View the duplicates to evaluate them
head(duplicates)
# Remove duplicate rows and keep only unique rows
forestfires_clean <- forestfires[!duplicated(forestfires), ]
# Print the number of rows after removing duplicates
print(paste("Number of rows after removing duplicates:", nrow(forestfires_clean)))
# Show descriptive statistics of the cleaned dataset
summary(forestfires_clean)



# Find Skewness -----------------------------------------------------------
# Calculate skewness and kurtosis for 'area'
skewness_area <- skewness(forestfires_clean$area)
kurtosis_area <- kurtosis(forestfires_clean$area)
# Print skewness and kurtosis
cat("Skewness of Burned Area: ", skewness_area, "\n")
cat("Kurtosis of Burned Area: ", kurtosis_area, "\n")
# Create a density plot for 'area'
ggplot(forestfires_clean, aes(x = area)) + 
  geom_density(fill = "red", alpha = 0.5) + 
  labs(title = "Density Plot of Burned Area", x = "Burned Area (ha)", y = "Density") + 
  theme_minimal()


# Create a density plot for 'log area'
ggplot(forestfires_clean, aes(x = area_log)) + 
  geom_density(fill = "red", alpha = 0.5) + 
  labs(title = "Density Plot of Burned Area", x = "Burned Area (ha)", y = "Density") + 
  theme_minimal()


# Detecting Outliers Methods ----------------------------------------------
## Detect outliers using box plots
## Boxplot of Burned Area
ggplot(forestfires_clean, aes(y = area)) + 
  geom_boxplot(fill = "lightblue") + 
  labs(title = "Boxplot of Burned Area", y = "Burned Area (ha)") + 
  theme_minimal()

## Boxplot of FFMC
ggplot(forestfires_clean, aes(y = FFMC)) + 
  geom_boxplot(fill = "lightblue") + 
  labs(title = "Boxplot of FFMC", y = "FFMC Index") + 
  theme_minimal()

## Boxplot of ISI
ggplot(forestfires_clean, aes(y = ISI)) + 
  geom_boxplot(fill = "lightblue") + 
  labs(title = "Boxplot of ISI", y = "ISI") + 
  theme_minimal()

## Boxplot of Rain
ggplot(forestfires_clean, aes(y = rain)) + 
  geom_boxplot(fill = "lightblue") + 
  labs(title = "Boxplot of rain", y = "Rain (mmm)") + 
  theme_minimal()


## Detect outliers using IQR method
# Function to calculate and identify outliers using IQR method
detect_outliers <- function(column_data, column_name) {
  Q1 <- quantile(column_data, 0.25)
  Q3 <- quantile(column_data, 0.75)
  IQR <- Q3 - Q1
  # Define lower and upper bounds
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  # Identify outliers
  outliers <- column_data[column_data < lower_bound | column_data > upper_bound]
  cat("Number of outliers detected in", column_name, ":", length(outliers), "\n")
  return(outliers)
}

# Detect outliers for area
outliers_area <- detect_outliers(forestfires$area, "area")
print(outliers_area)
# Detect outliers for FFMC
outliers_FFMC <- detect_outliers(forestfires$FFMC, "FFMC")
print(outliers_FFMC)
# Detect outliers for ISI
outliers_ISI <- detect_outliers(forestfires$ISI, "ISI")
print(outliers_ISI)
# Detect outliers for rain
outliers_rain <- detect_outliers(forestfires$rain, "rain")
print(outliers_rain)


# Log Transformation  -----------------------------------------------------
## area
forestfires_clean$area_log <- log(forestfires_clean$area + 1)
# Boxplot of log-transformed Burned Area
ggplot(forestfires_clean, aes(y = area_log)) + 
  geom_boxplot(fill = "purple") +
  labs(title = "Boxplot of Log-Transformed Burned Area", y = "Log(Burned Area + 1) (log(ha))") +
  theme_minimal()
# Summary of log-transformed Burned Area
summary(forestfires_clean$area_log)
# Skewness and Kurtosis for log-transformed Burned Area
cat("Skewness of log-area: ", skewness(forestfires_clean$area_log), "\n")
cat("Kurtosis of log-area: ", kurtosis(forestfires_clean$area_log), "\n")


## Reflecting and Log Transformation for FFMC
max_FFMC <- max(forestfires_clean$FFMC)
forestfires_clean$reflected_log_FFMC <- log(max_FFMC - forestfires_clean$FFMC + 1)
cat("Skewness of reflected log-FFMC: ", skewness(forestfires_clean$reflected_log_FFMC), "\n")
# Boxplot of log-transformed FFMC
ggplot(forestfires_clean, aes(y = reflected_log_FFMC)) + 
  geom_boxplot(fill = "purple") +
  labs(title = "Boxplot of Reflected Log-Transformed FFMC", y = "Reflected Log(FFMC)") +
  theme_minimal()
# Summary of log-transformed Burned Area
summary(forestfires_clean$log_FFMC)
# Skewness and Kurtosis for log-transformed Burned Area
cat("Skewness of log-FFMC: ", skewness(forestfires_clean$log_FFMC), "\n")
cat("Kurtosis of log-FFMC: ", kurtosis(forestfires_clean$log_FFMC), "\n")


## ISI
forestfires_clean$log_ISI <- log(forestfires_clean$ISI + 1)
# Boxplot of log-transformed ISI
ggplot(forestfires_clean, aes(y = log_ISI)) + 
  geom_boxplot(fill = "purple") +
  labs(title = "Boxplot of Log-Transformed ISI", y = "Log(ISI)") +
  theme_minimal()
# Summary of log-transformed ISI
summary(forestfires_clean$log_ISI)
# Skewness and Kurtosis for log-transformed ISI
cat("Skewness of log-ISI: ", skewness(forestfires_clean$log_ISI), "\n")
cat("Kurtosis of log-ISI: ", kurtosis(forestfires_clean$log_ISI), "\n")


# ## Rain
# forestfires_clean$log_rain <- log(forestfires_clean$rain + 1)
# # Boxplot of log-transformed Rain
# ggplot(forestfires_clean, aes(y = log_rain)) + 
#   geom_boxplot(fill = "purple") +
#   labs(title = "Boxplot of Log-Transformed Rain", y = "Log(Rain)") +
#   theme_minimal()
# # Summary of log-transformed Rain
# summary(forestfires_clean$log_rain)
# # Skewness and Kurtosis for log-transformed Rain
# cat("Skewness of log-Rain: ", skewness(forestfires_clean$log_rain), "\n")
# cat("Kurtosis of log-Rain: ", kurtosis(forestfires_clean$log_rain), "\n")


# Binning Rain into three categories: No Rain, Light Rain, Heavy Rain
forestfires_clean$rain_category <- ifelse(forestfires_clean$rain == 0, "No Rain",
                                          ifelse(forestfires_clean$rain <= 5, "Light Rain", "Heavy Rain"))
## order the rain levels
forestfires_clean$rain_category <- factor(forestfires_clean$rain_category,
                                          levels = c("No Rain", "Light Rain", "Heavy Rain"))

# Bar Plot
ggplot(forestfires_clean, aes(x = rain_category)) +
  geom_bar(fill = "purple") +
  labs(title = "Rainfall Categories",
       x = "Rainfall Category",
       y = "Frequency") +
  theme_minimal()


# Visualization of Distribution --------------------------------------------
# Histogram of Target Variables -----------------------------------------------
## Histogram of Burned Area
ggplot(forestfires_clean, aes(x = area)) + 
  geom_histogram(binwidth = 50, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of Burned Area", x = "Burned Area (ha)", y = "Frequency") + 
  theme_minimal()
# Raw burned area statistics
burned_area_stats <- data.frame(
  Mean = mean(forestfires_clean$area, na.rm = TRUE),
  Median = median(forestfires_clean$area, na.rm = TRUE),
  Skewness = skewness(forestfires_clean$area, na.rm = TRUE),
  Kurtosis = kurtosis(forestfires_clean$area, na.rm = TRUE)
)
print("Statistical Interpretation for Burned Area:")
print(burned_area_stats)




## Log-transform the burned area to reduce skewness
# Apply logarithmic transformation to the area variable (plus 1 to avoid log(0) issues)
forestfires_clean$area_log <- log(forestfires_clean$area + 1)

ggplot(forestfires_clean, aes(x = area_log)) + 
  geom_histogram(binwidth = 0.7, fill = "dodgerblue", color = "black") + 
  labs(title = "Log-Transformed Distribution of Burned Area", x = "Log(Burned Area + 1)", y = "Frequency") + 
  theme_minimal()
# Log-transformed burned area statistics
log_area_stats <- data.frame(
  Mean = mean(forestfires_clean$area_log, na.rm = TRUE),
  Median = median(forestfires_clean$area_log, na.rm = TRUE),
  Skewness = skewness(forestfires_clean$area_log, na.rm = TRUE),
  Kurtosis = kurtosis(forestfires_clean$area_log, na.rm = TRUE)
)
print("Statistical Interpretation for Log-Transformed Burned Area:")
print(log_area_stats)


## Histogram of Temperature
ggplot(forestfires_clean, aes(x = temp)) + 
  geom_histogram(binwidth = 5, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of Temperature", x = "Temperature (°C)", y = "Frequency") + 
  theme_minimal()
summary(forestfires_clean$temp)
cat("Skewness of Temperature: ", skewness(forestfires_clean$temp), "\n")
cat("Kurtosis of Temperature: ", kurtosis(forestfires_clean$temp), "\n")


## Histogram of Wind Speed
ggplot(forestfires_clean, aes(x = wind)) + 
  geom_histogram(binwidth = 1.7, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of Wind Speed", x = "Wind Speed (km/h)", y = "Frequency") + 
  theme_minimal()
summary(forestfires_clean$wind)
cat("Skewness of Wind Speed: ", skewness(forestfires_clean$wind), "\n")
cat("Kurtosis of Wind Speed: ", kurtosis(forestfires_clean$wind), "\n")



## Histogram of FFMC
ggplot(forestfires_clean, aes(x = FFMC)) + 
  geom_histogram(binwidth = 12, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of FFMC", x = "FFMC Index", y = "Frequency") + 
  theme_minimal()
summary(forestfires_clean$FFMC)
cat("Skewness of FFMC: ", skewness(forestfires_clean$FFMC), "\n")
cat("Kurtosis of FFMC: ", kurtosis(forestfires_clean$FFMC), "\n")


## Histogram of DMC
ggplot(forestfires_clean, aes(x = DMC)) + 
  geom_histogram(binwidth = 12, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of DMC", x = "DMC Index", y = "Frequency") + 
  theme_minimal()
summary(forestfires_clean$DMC)
cat("Skewness of DMC: ", skewness(forestfires_clean$DMC), "\n")
cat("Kurtosis of DMC: ", kurtosis(forestfires_clean$DMC), "\n")


## Histogram of DC (Drought Code)
ggplot(forestfires_clean, aes(x = DC)) + 
  geom_histogram(binwidth = 50, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of DC", x = "Drought Code (DC)", y = "Frequency") + 
  theme_minimal()
summary(forestfires_clean$DC)
cat("Skewness of DC: ", skewness(forestfires_clean$DC), "\n")
cat("Kurtosis of DC: ", kurtosis(forestfires_clean$DC), "\n")

## Histogram of ISI (Initial Spread Index)
ggplot(forestfires_clean, aes(x = ISI)) + 
  geom_histogram(binwidth = 2, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of ISI", x = "Initial Spread Index (ISI)", y = "Frequency") + 
  theme_minimal()
summary(forestfires_clean$ISI)
cat("Skewness of ISI: ", skewness(forestfires_clean$ISI), "\n")
cat("Kurtosis of ISI: ", kurtosis(forestfires_clean$ISI), "\n")

## Histogram of Relative Humidity (RH)
ggplot(forestfires_clean, aes(x = RH)) + 
  geom_histogram(binwidth = 5, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of Relative Humidity", x = "Relative Humidity (%)", y = "Frequency") + 
  theme_minimal()
summary(forestfires_clean$RH)
cat("Skewness of RH: ", skewness(forestfires_clean$RH), "\n")
cat("Kurtosis of RH: ", kurtosis(forestfires_clean$RH), "\n")

## Histogram of Rain
ggplot(forestfires_clean, aes(x = rain)) + 
  geom_histogram(binwidth = 0.5, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of Rain", x = "Rain (mm/m2)", y = "Frequency") + 
  theme_minimal()
summary(forestfires_clean$rain)
cat("Skewness of Rain: ", skewness(forestfires_clean$rain), "\n")
cat("Kurtosis of Rain: ", kurtosis(forestfires_clean$rain), "\n")

## Histogram of X (Spatial Coordinate)
ggplot(forestfires_clean, aes(x = X)) + 
  geom_histogram(binwidth = 0.9, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of X Coordinate", x = "X Spatial Coordinate", y = "Frequency") + 
  theme_minimal()
# Summary of X Coordinate
summary(forestfires_clean$X)
# Skewness and Kurtosis for X
cat("Skewness of X: ", skewness(forestfires_clean$X), "\n")
cat("Kurtosis of X: ", kurtosis(forestfires_clean$X), "\n")

## Histogram of Y (Spatial Coordinate)
ggplot(forestfires_clean, aes(x = Y)) + 
  geom_histogram(binwidth = 0.9, fill = "dodgerblue", color = "black") + 
  labs(title = "Distribution of Y Coordinate", x = "Y Spatial Coordinate", y = "Frequency") + 
  theme_minimal()
# Summary of Y Coordinate
summary(forestfires_clean$Y)
# Skewness and Kurtosis for Y
cat("Skewness of Y: ", skewness(forestfires_clean$Y), "\n")
cat("Kurtosis of Y: ", kurtosis(forestfires_clean$Y), "\n")


# Scatter Plot ------------------------------------------------------------
# Scatter Plot between Temperature and log_Burned Area
ggplot(forestfires_clean, aes(x = temp, y = area_log)) +
  geom_point(color = "dodgerblue", alpha = 0.7, size = 2.5) +  
  geom_smooth(method = "lm", color = "red", linetype = "dashed", se = TRUE, fill = "lightpink") +  # Add linear trend line with confidence interval
  labs(title = "Scatter Plot of Temperature vs Log-Burned Area", 
       x = "Temperature (°C)", 
       y = "Log-Burned Area (ha)") +
  theme()



# Scatter Plot between Wind and Log-Burned Area
ggplot(forestfires_clean, aes(x = wind, y = area_log)) +
  geom_point(color = "dodgerblue", alpha = 0.7, size = 2.5) +  
  geom_smooth(method = "lm", color = "red", linetype = "dashed", se = TRUE, fill = "lightpink") +  # trend line with confidence interval
  labs(
    title = "Scatter Plot of Wind Speed vs Log-Burned Area", 
    x = "Wind Speed (km/h)", 
    y = "Log-Burned Area (ha)"
  ) +
  theme()


# Scatter Plot for FFMC vs Log-Burned Area
ggplot(forestfires_clean, aes(x = FFMC, y = area_log)) +
  geom_point(color = "dodgerblue", alpha = 0.7, size = 2.5) +  
  geom_smooth(method = "lm", color = "red", linetype = "dashed", se = TRUE, fill = "lightpink") +  # trend line with confidence interval
  labs(
    title = "FFMC and Log-Burned Area",
    x = "FFMC Index", 
    y = "Log-Burned Area (ha)"
  ) +
  theme()

# Scatter Plot for DMC vs Log-Burned Area
ggplot(forestfires_clean, aes(x = DMC, y = area_log)) +
  geom_point(color = "dodgerblue", alpha = 0.7, size = 2.5) +  
  geom_smooth(method = "lm", color = "red", linetype = "dashed", se = TRUE, fill = "lightpink") +  # trend line with confidence interval
  labs(
    title = "DMC and Log-Burned Area",
    x = "DMC Index", 
    y = "Log-Burned Area (ha)"
  ) +
  theme()



# Bar & Box Plots for 'day' and 'month' -----------------------------------
forestfires_clean$month <- factor(forestfires_clean$month, levels = c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"))
# Bar plot for 'month' in chronological order
ggplot(forestfires_clean, aes(x = month)) + 
  geom_bar(fill = "dodgerblue") + 
  labs(title = "Number of Fires per Month", x = "Month", y = "Count") + 
  theme_minimal()

## Ensure the 'day' column is ordered by day of the week
forestfires_clean$day <- factor(forestfires_clean$day, levels = c("mon", "tue", "wed", "thu", "fri", "sat", "sun"))
# Bar plot for 'day' in chronological order
ggplot(forestfires_clean, aes(x = day)) + 
  geom_bar(fill = "dodgerblue") + 
  labs(title = "Number of Fires per Day of the Week", x = "Day of the Week", y = "Count") + 
  theme_minimal()


## Box plots Grouped by Categorical Variables (month, day)
# Boxplot of Burned Area by Month
ggplot(forestfires_clean, aes(x = month, y = area_log)) + 
  geom_boxplot(fill = "lightgreen") + 
  labs(title = "Log-Burned Area by Month", x = "Month", y = "Log-Burned Area") + 
  theme_minimal()
# Boxplot of Burned Area by Day
ggplot(forestfires_clean, aes(x = day, y = area_log)) + 
  geom_boxplot(fill = "lightgreen") + 
  labs(title = "Log-Burned Area by Day", x = "Day of Week", y = "Log-Burned Area") + 
  theme_minimal()


# Correlation Map ---------------------------------------------------------
# Select only numeric columns for correlation analysis
numeric_columns <- forestfires_clean[, sapply(forestfires_clean, is.numeric)]
# Compute the correlation matrix
correlation_matrix <- cor(numeric_columns)
# Create the correlation heatmap using ggcorrplot
ggcorrplot(correlation_matrix, 
           method = "square", 
           lab = TRUE,                        # Display correlation coefficients
           lab_size = 3,                      
           colors = c("darkred", "white", "darkgreen"), 
           title = "Correlation Heatmap", 
           tl.cex = 10,                       
           tl.srt = 45,                       
           tl.col = "black") +               
  theme_minimal(base_size = 12) +             
  theme(plot.title = element_text(hjust = 0.5, size = 16),  
        axis.text.x = element_text(angle = 45, hjust = 1),  
        axis.text.y = element_text(size = 10),              
        axis.title.x = element_blank(),                     # Remove x-axis title 
        axis.title.y = element_blank())                     # Remove y-axis title 



# Density Plot ------------------------------------------------------------
# Density plot for Temperature
ggplot(forestfires_clean, aes(x = temp)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of Temperature", x = "Temperature (°C)", y = "Density") +
  theme_minimal()

# Density plot for Wind Speed
ggplot(forestfires_clean, aes(x = wind)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of Wind Speed", x = "Wind Speed (km/h)", y = "Density") +
  theme_minimal()

# Density plot for FFMC
ggplot(forestfires_clean, aes(x = FFMC)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of FFMC", x = "FFMC Index", y = "Density") +
  theme_minimal()

# Density plot for DMC
ggplot(forestfires_clean, aes(x = DMC)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of DMC", x = "DMC Index", y = "Density") +
  theme_minimal()

# Density plot for DC 
ggplot(forestfires_clean, aes(x = DC)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of DC", x = "DC", y = "Density") +
  theme_minimal()

# Density plot for ISI
ggplot(forestfires_clean, aes(x = ISI)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of ISI", x = "ISI", y = "Density") +
  theme_minimal()

# Density plot for RH
ggplot(forestfires_clean, aes(x = RH)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of RH", x = "RH (%)", y = "Density") +
  theme_minimal()

# Density plot for Rain
ggplot(forestfires_clean, aes(x = rain)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of Rain", x = "Rain (mm)", y = "Density") +
  theme_minimal()

# Density plot for X
ggplot(forestfires_clean, aes(x = X)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of X Coordinate", x = "X Coordinate", y = "Density") +
  theme_minimal()

# Density plot for Y
ggplot(forestfires_clean, aes(x = Y)) +
  geom_density(fill = "pink", color = "black", alpha = 0.5) +
  labs(title = "Density Plot of Y Coordinate", x = "Y Coordinate", y = "Density") +
  theme_minimal()



# Splitting Dataset -------------------------------------------------------
# Set seed for reproducibility
set.seed(123)

# Stratified sampling on the 'area_log' column to maintain the distribution
train_index <- createDataPartition(forestfires_clean$area_log, p = 0.7, list = FALSE)

train_data <- forestfires_clean[train_index, ]
test_data <- forestfires_clean[-train_index, ]


# Encoding 'month' and 'day' ----------------------------------------------
## One-Hot Encoding for TRAIN set
# Apply dummyVars to the training data
dummies <- dummyVars(~ month + day, data = train_data)
encoded_train <- predict(dummies, newdata = train_data)
encoded_train <- as.data.frame(encoded_train)
# Add encoded columns to train_data and remove original
train_data <- cbind(train_data, encoded_train)
train_data$month <- NULL
train_data$day <- NULL


## One-Hot Encoding for TEST set
# Encode the test set
encoded_test <- predict(dummies, newdata = test_data)
encoded_test <- as.data.frame(encoded_test)
# Add encoded columns to test_data and remove original
test_data <- cbind(test_data, encoded_test)
test_data$month <- NULL
test_data$day <- NULL

# Check the structure
str(train_data)
str(test_data)

# Feature Engineering -----------------------------------------------------
## Effect of Temperature and RH
# Training Set
train_data <- train_data %>%
  mutate(
    Temp_RH_Interaction = temp * RH,
    Temp_Wind_Interaction = temp * wind,
    CFRI_log = (reflected_log_FFMC + DMC + DC + log_ISI) / 4
  )

# Testing Set
test_data <- test_data %>%
  mutate(
    Temp_RH_Interaction = temp * RH,
    Temp_Wind_Interaction = temp * wind,
    CFRI_log = (reflected_log_FFMC + DMC + DC + log_ISI) / 4
  )


# Summary for training data
summary(train_data$Temp_RH_Interaction)
summary(train_data$Temp_Wind_Interaction)
summary(train_data$CFRI_log)


# Histogram for Temp_RH_Interaction
ggplot(train_data, aes(x = Temp_RH_Interaction)) + 
  geom_histogram(binwidth = 20, fill = "dodgerblue", color = "black") +
  labs(title = "Distribution of Temperature × Relative Humidity Interaction (Training Set)", 
       x = "Temp × RH", y = "Count") +
  theme_minimal()

# Histogram for Temp_Wind_Interaction
ggplot(train_data, aes(x = Temp_Wind_Interaction)) + 
  geom_histogram(binwidth = 5, fill = "dodgerblue", color = "black") +
  labs(title = "Distribution of Temperature × Wind Speed Interaction (Training Set)", 
       x = "Temp × Wind", y = "Count") +
  theme_minimal()

# Histogram for CFRI_log
ggplot(train_data, aes(x = CFRI_log)) + 
  geom_histogram(binwidth = 10, fill = "dodgerblue", color = "black") +
  labs(title = "Distribution of Composite Fire Risk Index (Log-transformed CFRI) (Training Set)", 
       x = "CFRI_Log", y = "Count") +
  theme_minimal()


# # Export the cleaned and transformed dataset to a CSV file
# write.csv(forestfires_clean, file = "forestfires_cleaned.csv", row.names = FALSE)


# Normalization -----------------------------------------------------------
#Normalization (Min-Max Scaling)
normalizer <- preProcess(train_data, method = c("range"))
# Normalizing train and test datasets
train_normalized <- predict(normalizer, train_data)
test_normalized <- predict(normalizer, test_data)
# Summary of Training Data after Normalization
summary(train_normalized)



# train_file_path <- "train_data_normalized.csv"
# test_file_path <- "test_data_normalized.csv"
# write.csv(train_normalized, train_file_path, row.names = FALSE)
# write.csv(test_normalized, test_file_path, row.names = FALSE)




