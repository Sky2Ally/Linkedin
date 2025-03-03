#Install and load necessary libraries
install.packages("imputeTS")
install.packages("caret")
install.packages("randomForest")
install.packages("rpart")
install.packages("rpart.plot")
library(imputeTS)
library(dplyr)
library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)
 
# Load the dataset
forestfires <- read.csv("forestfires.csv")
View(forestfires)
 
# Check for missing values
Missing_Values <- colSums(is.na(forestfires))
print(Missing_Values)
 
# Print all unique features of month and day columns to identify abnormalities.
unique_month <- unique(forestfires$month)
unique_day <- unique(forestfires$day)
print(unique_month)
print(unique_day)
 
# Normalize the 'area' column using Min-Max normalization
min_value <- min(forestfires$area)
max_value <- max(forestfires$area)
forestfires$area_norm <- (forestfires$area - min_value) / (max_value - min_value)
 
# Move the normalized column to be before the original 'area' column
forestfires <- forestfires %>% relocate(area_norm, .before = area)
 
# Prepare the data for modeling - remove non-numeric or unimportant columns
df2 <- df2 %>% select(-month, -day)  # Assuming 'month' and 'day' are categorical
 
# Split the data into training (70%) and test (30%) sets with stratified sampling
set.seed(123)  # For reproducibility
splitIndex <- createDataPartition(df2$area, p = 0.7, list = FALSE)
 
# Create training and test datasets
train_data <- df2[splitIndex, ]
test_data <- df2[-splitIndex, ]
 
# Cross-validation control
control <- trainControl(method = "cv", number = 10)
 
# Random Forest Model
set.seed(123)
rf_model <- train(area ~ ., data = train_data, method = "rf", trControl = control)
 
# Predict on the test set using Random Forest
rf_predictions <- predict(rf_model, test_data)
 
# Decision Tree Model
set.seed(123)
dt_model <- train(area ~ ., data = train_data, method = "rpart", trControl = control)
 
# Predict on the test set using Decision Tree
dt_predictions <- predict(dt_model, test_data)
 
# Evaluate the models
rf_mse <- mean((rf_predictions - test_data$area)^2)
dt_mse <- mean((dt_predictions - test_data$area)^2)
 
print(paste("Random Forest MSE:", rf_mse))
print(paste("Decision Tree MSE:", dt_mse))

# RMSE
print(paste("Random Forest RMSE:", rf_rmse))
print(paste("Decision Tree RMSE:", dt_rmse))

# MAE
print(paste("Random Forest MAE:", rf_mae))
print(paste("Decision Tree MAE:", dt_mae))

# R-Squared
print(paste("Random Forest R-Squared:", rf_r2))
print(paste("Decision Tree R-Squared:", dt_r2))

# Plot Decision Tree
rpart.plot(dt_model$finalModel)
 
# View variable importance from Random Forest
varImpPlot(rf_model$finalModel)

