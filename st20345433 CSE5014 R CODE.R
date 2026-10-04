#----------------------------------- TASK 3------------------------------------------------

# install required packages

install.packages("ggplot2")
install.packages("dplyr")

# Load required packages
library(ggplot2)
library(dplyr)

# Load the dataset
telecom <- read.csv("Telecom_Info_Updated_V2.csv")

# Check loaded correctly
head(telecom)

# Function to calculate mode as taught in Session 7
get_mode <- function(x) {
  names(sort(table(x), decreasing = TRUE))[1]
}

# Calculate Mean, Median, and Mode for all 5 variables
telecom %>%
  summarise(
    Mean_MonthlyCharges = mean(MonthlyCharges),
    Median_MonthlyCharges = median(MonthlyCharges),
    Mode_MonthlyCharges = get_mode(MonthlyCharges),
    
    Mean_DataUsage = mean(DataUsageGB),
    Median_DataUsage = median(DataUsageGB),
    Mode_DataUsage = get_mode(DataUsageGB),
    
    Mean_CallMinutes = mean(CallMinutes),
    Median_CallMinutes = median(CallMinutes),
    Mode_CallMinutes = get_mode(CallMinutes),
    
    Mean_Tenure = mean(CustomerTenureMonths),
    Median_Tenure = median(CustomerTenureMonths),
    Mode_Tenure = get_mode(CustomerTenureMonths),
    
    Mean_Churn = mean(ChurnProbability),
    Median_Churn = median(ChurnProbability),
    Mode_Churn = get_mode(ChurnProbability)
  )

# Bell Curve for Monthly Charges
ggplot(telecom, aes(x = MonthlyCharges)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "lightblue", color = "black") +
  geom_density(color = "blue", size = 1) +
  labs(title = "Distribution of Monthly Charges", x = "Monthly Charges (USD)", y = "Density")

# Bell Curve for Data Usage
ggplot(telecom, aes(x = DataUsageGB)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "lightgreen", color = "black") +
  geom_density(color = "darkgreen", size = 1) +
  labs(title = "Distribution of Data Usage", x = "Data Usage (GB)", y = "Density")

# Bell Curve for Call Minutes
ggplot(telecom, aes(x = CallMinutes)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "lightcoral", color = "black") +
  geom_density(color = "red", size = 1) +
  labs(title = "Distribution of Call Minutes", x = "Call Minutes", y = "Density")

# Bell Curve for Customer Tenure
ggplot(telecom, aes(x = CustomerTenureMonths)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "lightgoldenrod", color = "black") +
  geom_density(color = "orange", size = 1) +
  labs(title = "Distribution of Customer Tenure", x = "Tenure (Months)", y = "Density")

# Bell Curve for Churn Probability
ggplot(telecom, aes(x = ChurnProbability)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "lightpink", color = "black") +
  geom_density(color = "purple", size = 1) +
  labs(title = "Distribution of Churn Probability", x = "Churn Probability", y = "Density")

#--------------------------------- TASK 3 END----------------------------------

#------------------------------------TASK 4------------------------------------


# Standardize the column name to avoid issues with the space in "customer type"
colnames(telecom)[colnames(telecom) == "customer.type"] <- "CustomerType"
colnames(telecom)[colnames(telecom) == "customer type"] <- "CustomerType"

# Run the One Way ANOVA
anova_model <- aov(ChurnProbability ~ CustomerType, data = telecom)

# View the ANOVA p value
summary(anova_model)

# Run Tukey HSD test to see the differences between specific groups
TukeyHSD(anova_model)

# Create the Boxplot
ggplot(telecom, aes(x = CustomerType, y = ChurnProbability, fill = CustomerType)) +
  geom_boxplot(alpha = 0.7, color = "black") +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 5, color = "darkred", fill = "red") +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Churn Probability by Customer Type", 
       x = "Customer Type", 
       y = "Churn Probability (0-10 Scale)") +
  theme_minimal() +
  theme(legend.position = "none", plot.title = element_text(size=14, face="bold"))

#--------------------------------- TASK 4 END----------------------------------


#----------------------------------- TASK 5 -----------------------------------

# install Packages 

install.packages("corrplot")
install.packages("car")

# 1. LOAD DATA & LIBRARIES

library(corrplot)
library(car) # For VIF

# 2. NORMALITY TESTING

shapiro.test(telecom$MonthlyCharges)
shapiro.test(telecom$DataUsageGB)
shapiro.test(telecom$CallMinutes)
shapiro.test(telecom$CustomerTenureMonths)
shapiro.test(telecom$NumComplaints)
shapiro.test(telecom$ChurnProbability)


# 3. Q-Q PLOTS

par(mfrow = c(3, 2))
qqnorm(telecom$MonthlyCharges, main = "Q-Q: Monthly Charges"); qqline(telecom$MonthlyCharges, col = "red", lwd=2)
qqnorm(telecom$DataUsageGB, main = "Q-Q: Data Usage"); qqline(telecom$DataUsageGB, col = "red", lwd=2)
qqnorm(telecom$CallMinutes, main = "Q-Q: Call Minutes"); qqline(telecom$CallMinutes, col = "red", lwd=2)
qqnorm(telecom$CustomerTenureMonths, main = "Q-Q: Customer Tenure"); qqline(telecom$CustomerTenureMonths, col = "red", lwd=2)
qqnorm(telecom$NumComplaints, main = "Q-Q: Complaints"); qqline(telecom$NumComplaints, col = "red", lwd=2)
qqnorm(telecom$ChurnProbability, main = "Q-Q: Churn Probability"); qqline(telecom$ChurnProbability, col = "red", lwd=2)
par(mfrow = c(1, 1))


# 4. PEARSON vs SPEARMAN CORRELATION

# Pearson
cor.test(telecom$MonthlyCharges, telecom$ChurnProbability, method = "pearson")
# Spearman
cor.test(telecom$MonthlyCharges, telecom$ChurnProbability, method = "spearman", exact = FALSE)
# (Repeat for the other 4 variables if you want full console proof)


# 5. SCATTERPLOTS

ggplot(telecom, aes(x = MonthlyCharges, y = ChurnProbability)) +
  geom_point(alpha = 0.4, color="blue") + geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Monthly Charges vs Churn Probability") + theme_minimal()

ggplot(telecom, aes(x = DataUsageGB, y = ChurnProbability)) +
  geom_point(alpha = 0.4, color="green") + geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Data Usage vs Churn Probability") + theme_minimal()

ggplot(telecom, aes(x = CallMinutes, y = ChurnProbability)) +
  geom_point(alpha = 0.4, color="purple") + geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Call Minutes vs Churn Probability") + theme_minimal()

ggplot(telecom, aes(x = CustomerTenureMonths, y = ChurnProbability)) +
  geom_point(alpha = 0.4, color="orange") + geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Customer Tenure vs Churn Probability") + theme_minimal()

ggplot(telecom, aes(x = NumComplaints, y = ChurnProbability)) +
  geom_point(alpha = 0.4, color="brown") + geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Number of Complaints vs Churn Probability") + theme_minimal()


# 6. CORRELATION MATRIX

numeric_data <- telecom[, c("MonthlyCharges", "DataUsageGB", "CallMinutes", "CustomerTenureMonths", "NumComplaints", "ChurnProbability")]
cor_matrix <- cor(numeric_data, use = "complete.obs", method = "pearson")
corrplot(cor_matrix, method = "color", type = "upper", addCoef.col = "black", tl.col = "black")


# 7. MULTIPLE LINEAR REGRESSION & VIF

regression_model <- lm(ChurnProbability ~ MonthlyCharges + DataUsageGB + CallMinutes + CustomerTenureMonths + NumComplaints, data = telecom)
summary(regression_model)

# Multicollinearity check
vif(regression_model)


# 8. REGRESSION DIAGNOSTIC PLOTS (Take screenshot of 2x2 grid)

par(mfrow = c(2, 2))
plot(regression_model)
par(mfrow = c(1, 1))

#--------------------------------- TASK 5 END----------------------------------
