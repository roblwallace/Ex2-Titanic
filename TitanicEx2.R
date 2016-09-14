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
#install.packages("dplyr")
#install.packages("tidyr")
library("dplyr")
library("tidyr")

# Step 0. Load the data in RStudio / 14 Variables & 1,310 Observations
# Turn of stringsAsFactors to enable inserting new values, or learn to change Factor levels
titanic_original = read.csv("titanic_original.csv", header = TRUE, stringsAsFactors = FALSE)
df_temp <- data.frame(titanic_original)
# tbl_df is a command in the dplyr data table management package.  It prevents long table outputs
# when accidentially calling the data table or dataframe
df_titanic <- dplyr::tbl_df(df_temp)

# Get a look at the content
glimpse(df_titanic)
#######################
##
# Step 1. Missing port of embarkation s/b 'S'
##
#######################
# Loop through embarkation and put an 'S' where missing
# **Commenting Out** the old For Loop from compiler, to take advantage of R automation
#for (x in 1:nrow(df_titanic)) {
#  if (df_titanic$embarked[x] == "") {
#    df_titanic$embarked[x] <- 'S'
#  }
#}

# THis works. If embarked has a 0 length string replace w/'S'.  Trying another approach below
#df_titanic$embarked <- ifelse(nchar(df_titanic$embarked)==0,"S", df_titanic$embarked)

# New code using R automation
# Missing values in emarked column replaced with 'S' (Southampton)
df_titanic$embarked[df_titanic$embarked==""] <- "S"

####################
##
# Step 2. Age Missing Values as mean(age)
##
####################
# Calculate the mean(age) of dataset (-263 rows, mean 29.88113)
# Filter out the blanks in age as mean() returns NA
df_age <- filter(df_titanic, df_titanic$age != "")

# Calculate the mean (tested in excel as 29.88113451)
t_mean_age <- mean(df_age$age)

# Loop through table and replace "" (blanks) & insert t_mean_age 
# **Commenting Out** the old For Loop from complier, to take advantage of R automation
#for (x in 1:nrow(df_titanic)) {
#  print(df_titanic$age[x])
#  if (is.na(df_titanic$age[x])) {
#    df_titanic$age[x] <- t_mean_age
#  }
#}

# New Code Using R Automation
# Replace missing age with mean calc'd above 29.88113
# This works using replace_na from {tidyr}
#df_titanic <- df_titanic %>% replace_na(list(age = 29.88113))

# Different approach. Similar technique to Step 1
# if age = NA replaces with calcuated t_mean_age
df_titanic$age[is.na(df_titanic$age)] <- t_mean_age

#########################
##
# Step 3. Lifeboat missing values insert 'None'
##
#########################
# Checking in Excel 823 records have missing Lifeboat info
# **Commenting Out** the old For Loop from complier, to take advantage of R automation
#for (x in 1:nrow(df_titanic)) {
#  if (df_titanic$boat[x] == "") {
#    df_titanic$boat[x] <- "None"
#  }
#}

# if (number of characters) in $boat == 0 (i.e. blank) replace with "None" 
# This works.  Trying another approach
#df_titanic$boat <- ifelse(nchar(df_titanic$boat)==0, "None", df_titanic$boat)

# Shortened .. if nchar is 0 (zero) then replace with "None"
df_titanic$boat[nchar(df_titanic$boat)==0] <- "None"

##########################
##
# Step 4 Cabin: New col as 0 or 1 (integer)
##
##########################
df_titanic <- mutate(df_titanic, has_cabin_number = as.integer(df_titanic$cabin != ""))

##########################
##
# Step 5 - No Step 5 within instructions
##
##########################

##########################
##
# Step 6 - Submit on Github as titanic_clean.csv
##
##########################
write.csv(df_titanic, file = "titanic_clean.csv")


