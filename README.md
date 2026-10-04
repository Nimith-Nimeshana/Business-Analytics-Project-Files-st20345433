## 📌 Project Overview
This repository contains the data analysis, R scripts, and academic report for a Business Analytics project investigating customer attrition (churn) within the Sri Lankan telecommunication sector. The objective of this project is to develop statistical decision models that support evidence-based, data-driven decision-making for customer retention.

## 📂 Repository Contents
*   **`Telecom_Info_Updated_V2.csv`**
*   **`st20345433 CSE5011 R CODE.R`**

## 🛠 Tools & Technologies
*   **Language:** R
*   **Environment:** RStudio
*   **Key R Packages Used:** 
    *   `dplyr` (Data manipulation and aggregation)
    *   `ggplot2` (Data visualization and bell curves)
    *   `corrplot` (Correlation matrix visualization)
    *   `car` (Variance Inflation Factor / Multicollinearity checks)

## 📊 Key Analytical Steps
1.  **Descriptive Statistics & Data Visualization:** Analyzed the central tendency (Mean, Median, Mode) and visualized data distributions using histograms overlaid with density curves to assess skewness and normality.
2.  **Analysis of Variance (ANOVA):** Conducted One-Way ANOVA and Tukey HSD post-hoc tests to determine if Churn Probability significantly differs across Customer Types (Individual, Business, VIP).
3.  **Statistical Relationship Analysis:**
    *   **Normality Testing:** Assessed variables using the Shapiro-Wilk test and Q-Q plots.
    *   **Correlation Analysis:** Measured associations using Pearson and Spearman correlation methods.
    *   **Multiple Linear Regression:** Built a predictive model to isolate the true drivers of churn, heavily supported by multicollinearity (VIF) and residual diagnostic checks.

## 🚀 How to Run the Code
1. Clone this repository to your local machine.
2. Ensure you have R and RStudio installed.
3. Open `st20345433 CSE5011 R CODE.R` in RStudio.
4. Set your working directory to the folder containing the dataset:
   ```R
   setwd("path/to/your/folder")

**Student Name:** Nimith Nimeshana Mallawa  
**Cardiff Metropolitan University ID:** st20345433  
**ICBT Campus Student ID:** AN/HDCSE/CMU/01/09  
**Module:** CSE5014 - Business Analytics (WRIT1)  
