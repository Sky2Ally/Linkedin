install.packages("imputeTS")
install.packages("corrplot")
install.packages("ggplot2")
library(imputeTS)
library(dplyr)  # For data manipulation
library(ggplot2)  # For visualizations
library(corrplot) # For correlation matrix


df <- forestfires <- read.csv("forestfires.csv")
View(forestfires)



# Check for NA values in each column
Missing_Values <- colSums(is.na(forestfires))

# Print the number of NA values per column
print(Missing_Values)



# Print all unique features of month column to identify abnormalities.
unique_features <- unique(forestfires$month)

# Print the unique values
print(unique_features)

# Print all unique features of day column to identify abnormalities.
unique_features2 <- unique(forestfires$day)

# Print the unique values
print(unique_features2)

##

# Correlation Analysis: Correlation matrix for numerical variables
numeric_vars <- forestfires %>%
  select_if(is.numeric)

# Compute the correlation matrix
correlation_matrix <- cor(numeric_vars)

# Visualize the correlation matrix using corrplot
corrplot(correlation_matrix, method = "color", type = "lower", 
         tl.col = "black", tl.srt = 45, title = "Correlation Matrix")

# Scatter Plots: Exploring relationships between 'Area' and key predictors (e.g., Temperature, Wind, Humidity)
# Scatter plot for Temp vs Area
ggplot(forestfires, aes(x = temp, y = area)) +
  geom_point(alpha = 0.6, color = "blue") +
  geom_smooth(method = "lm", col = "red") +  # Adding a linear regression line
  ggtitle("Scatter plot of Temperature vs Fire Area") +
  xlab("Temperature (°C)") +
  ylab("Area (hectares)")

# Scatter plot for Wind vs Area
ggplot(forestfires, aes(x = wind, y = area)) +
  geom_point(alpha = 0.6, color = "green") +
  geom_smooth(method = "lm", col = "red") +  # Adding a linear regression line
  ggtitle("Scatter plot of Wind vs Fire Area") +
  xlab("Wind Speed (km/h)") +
  ylab("Area (hectares)")

# Scatter plot for RH (relative humidity) vs Area
ggplot(forestfires, aes(x = RH, y = area)) +
  geom_point(alpha = 0.6, color = "purple") +
  geom_smooth(method = "lm", col = "red") +  # Adding a linear regression line
  ggtitle("Scatter plot of Humidity (RH) vs Fire Area") +
  xlab("Humidity (%)") +
  ylab("Area (hectares)")

# Histograms and Box Plots: Checking the distribution of numerical variables
# Histogram for Area
ggplot(forestfires, aes(x = area)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.7) +
  ggtitle("Histogram of Fire Area") +
  xlab("Area (hectares)") +
  ylab("Frequency")

# Boxplot for Area to identify outliers
ggplot(forestfires, aes(y = area)) +
  geom_boxplot(fill = "orange", color = "black") +
  ggtitle("Boxplot of Fire Area") +
  ylab("Area (hectares)")

# Additional Boxplots for other variables (e.g., Temperature, Wind)
# Boxplot for Temperature
ggplot(forestfires, aes(y = temp)) +
  geom_boxplot(fill = "green", color = "black") +
  ggtitle("Boxplot of Temperature") +
  ylab("Temperature (°C)")

# Boxplot for Wind
ggplot(forestfires, aes(y = wind)) +
  geom_boxplot(fill = "red", color = "black") +
  ggtitle("Boxplot of Wind Speed") +
  ylab("Wind Speed (km/h)")

##

# Function to apply Min-Max normalization to a single column
min_max_normalize <- function(column) {
  return((column - min(column)) / (max(column) - min(column)))
}

# Ensure all numerical columns are selected
numerical_columns <- df[, sapply(df, is.numeric)]

# Apply Min-Max normalization to each numerical column
df[, names(numerical_columns)] <- lapply(numerical_columns, min_max_normalize)

# Verify that the normalization worked
sapply(df[, names(numerical_columns)], range)

# Save the normalized dataset to a new CSV
write.csv(df, file = "normalized_forestfires.csv", row.names = FALSE)

# Print a message to confirm the normalization
cat("Normalization completed and saved to 'normalized_forestfires.csv'.\n")

#load the normalised data
df2 <- nforestfires <- read.csv("normalized_forestfires.csv")
View(nforestfires)

##



