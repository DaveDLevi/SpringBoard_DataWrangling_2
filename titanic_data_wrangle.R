# csv imported

# convert to tbl_df

titanic <- tbl_df(titanic_original)


# updated embarked column so NA = Southhampton

  # get count of each embarked
    
  titanic %>% count(embarked)

# note 3 NAs
#       C   270
#       Q   123
#       S   914
#      <NA>     3

# gsub NA to 'S'
# initially was trying to use select %>% filter %>% mutate, but saying I was only passing 3 variables, when there should be 1300



# gsub on embarked col with ifelse

titanic =  mutate(titanic, embarked = ifelse(is.na(titanic$embarked), "S", titanic$embarked))
                             

# age
# test initially mean(titanic$age) == "NA"

#find is.na in age and replace mean for NA
titanic = mutate(titanic, age = ifelse(is.na(titanic$age), mean(titanic$age, na.rm = TRUE), age))

# follow up test: mean(titanic$age) == 29.88113
# conclusion: age no longer contains NA

# other ways to replace besides mean
# median - might be better than mean depending on breakdown of outliers
# further categorize mean/median - look at median survival age and median non-survival age, and how strongly correlated with other factors, such as cabin, sex, 
#   socioeconomic status, etc. and apply the specific mean that most closely defines specific row.


# Lifeboat

#replaced NA with "None" in boat column 
titanic = mutate(titanic, boat = ifelse(is.na(titanic$boat), "None", boat))
  
# cabin number

# why would they have a blank?

#titanic %>% count(is.na(cabin))
# A tibble: 2 × 2
      #`is.na(cabin)`     n
                #<lgl> <int>
  #  1          FALSE   295
  #  2           TRUE  1015

# Individual's without cabin possibly crew of ship...roughly 300 crew makes logical sense in terms of numbers
# Does not make sense to replace if no cabin indicates crew.  Crew should have own category

# adding has_cabin_number

titanic = mutate(titanic, has_cabin_number = ifelse(is.na(cabin), 1, 0))

#save files and upload to github

write.csv(titanic, "titanic_clean.csv")


                  