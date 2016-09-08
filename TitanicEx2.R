# Data Wrangling Exercise 2
# Dealing with missing values
# Rob Wallace, Sept 8, 2016
#
# Using R, you'll be handling missing values in this data set, and creating a
# new data set.  Specifically, these are the tasks you need to do:
# 0. Load the data in RStudio
# 1. Port of embarkation
# 2. Age
# 3. Lifeboat
# 4. Cabin
# 5. (No Five on the instructions)
# 6. Submit the project to GitHub

# Get Library or Package Wanted
library("dplyr")
library("tidyr")

# Step 0. Load the data in RStudio / 14 Variables & 1,310 Observations
# Turn of stringsAsFactors to enable inserting new values, or learn to change Factor levels
df_titanic = read.csv("titanic_original.csv", header = TRUE, stringsAsFactors = FALSE)


# Get a look at the content
glimpse(df_titanic)

# Step 1. Missing port of embarkation s/b 'S'
# Loop through embarkation and put an 'S' where missing
for (x in 1:nrow(df_titanic)) {
  if (df_titanic$embarked[x] == "") {
    df_titanic$embarked[x] <- 'S'
  }
}
  
# Step 2. Age Missing Values as mean(age)
# Calculate the mean(age) of dataset (-263 rows, mean 29.88113)
# Filter out the blanks in age as mean() returns NA
df_age <- filter(df_titanic, df_titanic$age != "")

# Calculate the mean (tested in excel as 29.88113451)
t_mean_age <- mean(df_age$age)

# Loop through table and replace "" (blanks) & insert t_mean_age 
for (x in 1:nrow(df_titanic)) {
  print(df_titanic$age[x])
  if (is.na(df_titanic$age[x])) {
    df_titanic$age[x] <- t_mean_age
  }
}

# Step 3. Lifeboat missing values insert 'None'
# Checking in Excel 823 records have missing Lifeboat info
for (x in 1:nrow(df_titanic)) {
  if (df_titanic$boat[x] == "") {
    df_titanic$boat[x] <- "None"
  }
}

# Step 4 Cabin: New col as 0 or 1 (integer)
df_titanic <- mutate(df_titanic, has_cabin_number = as.integer(df_titanic$cabin != ""))

# Step 5 - No Step 5 within instructions
# Step 6 - Submit on Github as titanic_clean.csv
write.csv(df_titanic, file = "titanic_clean.csv")


