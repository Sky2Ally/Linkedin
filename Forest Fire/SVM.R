# Load necessary libraries
library(e1071)      # For SVM
library(caret)      # For data partitioning and cross-validation
library(ggplot2)    # For visualization
library(dplyr)      # For data manipulation

# Load the dataset (assuming the dataset is already normalized and cleaned)
df <- read.csv("normalized_forestfires.csv")

# Drop categorical variables like 'month' and 'day', which might not be useful in regression
df <- df %>% select(-month, -day)


# Split the data into training (70%) and testing (30%) sets with stratified sampling based on 'area_category'
set.seed(123)  # For reproducibility
train_indices <- createDataPartition(df$area, p = 0.7, list = FALSE)
train_data <- df[train_indices, ]
test_data <- df[-train_indices, ]

# Define the control function for cross-validation
train_control <- trainControl(method = "cv", number = 10)  # 10-fold cross-validation

# Train the SVM model for regression using 'area' as the dependent variable with cross-validation
svm_model <- train(area ~ ., data = train_data, method = "svmRadial", 
                   trControl = train_control, 
                   tuneGrid = expand.grid(sigma = 0.1, C = 10))

# Print the best model results
print(svm_model)

# Predict 'area' using the test dataset
predicted_area <- predict(svm_model, newdata = test_data)

# Evaluate the model: Calculate MSE, RMSE, MAE, and R-squared
# Mean Squared Error (MSE)
mse <- mean((test_data$area - predicted_area)^2)

# Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Mean Absolute Error (MAE)
mae <- mean(abs(test_data$area - predicted_area))

# R-squared
sst <- sum((test_data$area - mean(test_data$area))^2)  # Total sum of squares
ssr <- sum((predicted_area - mean(test_data$area))^2)  # Explained sum of squares
r_squared <- ssr / sst

# Print the results
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")
cat("MAE: ", mae, "\n")
cat("R-squared: ", r_squared, "\n")

# Optional: Plot the predicted vs actual values
ggplot(data.frame(actual = test_data$area, predicted = predicted_area), aes(x = actual, y = predicted)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_abline(slope = 1, intercept = 0, col = "red", linetype = "dashed") +
  ggtitle("Actual vs Predicted Fire Area using SVM") +
  xlab("Actual Fire Area") +
  ylab("Predicted Fire Area")
