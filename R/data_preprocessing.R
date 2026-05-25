# =========================================
# 01_data_preprocessing.R
# =========================================

# Load libraries (only what is needed here)
library(tidyverse)
library(dplyr)

# -----------------------------
# 1. Load raw dataset
# -----------------------------
typhoid_data <- read.csv(
  "data/Typhoid_dataset.csv",
  stringsAsFactors = FALSE
)

# Quick check
head(typhoid_data)


# -----------------------------
# 2. Convert categorical variables
# -----------------------------
cols_to_factor <- c(
  "Gender", 
  "Location", 
  "Socioeconomic.Status", 
  "Water.Source.Type", 
  "Sanitation.Facilities", 
  "Hand.Hygiene", 
  "Consumption.of.Street.Food", 
  "Gastrointestinal.Symptoms", 
  "Neurological.Symptoms", 
  "Skin.Manifestations", 
  "Complications", 
  "Blood.Culture.Result", 
  "Widal.Test", 
  "Typhidot.Test", 
  "Typhoid.Vaccination.Status", 
  "Previous.History.of.Typhoid", 
  "Weather.Condition", 
  "Ongoing.Infection.in.Society", 
  "Typhoid.Status"
)

typhoid_data[cols_to_factor] <- lapply(
  typhoid_data[cols_to_factor],
  as.factor
)

 OR 

typhoid_data <- typhoid_data %>% 
                mutate(across(where(is.character), as.factor))

# -----------------------------
# 3. Clean target variable
# -----------------------------
typhoid_data$Typhoid.Status <- ifelse(
  typhoid_data$Typhoid.Status == "Normal or No Typhoid",
  "Negative",
  "positive"
)

typhoid_data$Typhoid.Status <- as.factor(typhoid_data$Typhoid.Status)

table(typhoid_data$Typhoid.Status)


# -----------------------------
# 4. Save cleaned dataset
# -----------------------------
write.csv(
  typhoid_data,
  "data/typhoid_cleaned.csv",
  row.names = FALSE
)

# Optional confirmation
data_check = read.csv("data/typhoid_cleaned.csv")

head(data_check) 
