library(randomForest)

data <- read.csv('~/patient_churn.csv')

setup_data <- function(data) {
  churn_columns <- c(
    "churn_A",
    "churn_B",
    "churn_C",
    "churn_D",
    "churn_E",
    "churn_F"
  )
  colnames(data) <- c(
    "ID",
    "sex",
    "birth",
    "death",
    "enrollment",
    "visits",
    churn_columns
  )
  
  # Assign an "impossible" value to differentiante NAs within
  # our Random Forest, which requires non-NA values to be trained
  data[is.na(data$death), "death"] <- -1
  
  data$churn_A <- ifelse(data$churn_A == 1, "A", "")
  data$churn_B <- ifelse(data$churn_B == 1, "B", "")
  data$churn_C <- ifelse(data$churn_C == 1, "C", "")
  data$churn_D <- ifelse(data$churn_D == 1, "D", "")
  data$churn_E <- ifelse(data$churn_E == 1, "E", "")
  data$churn_F <- ifelse(data$churn_F == 1, "F", "")
  data$churn <- paste(
    data$churn_A,
    data$churn_B,
    data$churn_C,
    data$churn_D,
    data$churn_E,
    data$churn_F,
    sep = ""
  )
  data[data$churn == "", "churn"] <- "X"
  data[data$churn_A == "", "churn_A"] <- "X"
  data[data$churn_B == "", "churn_B"] <- "X"
  data[data$churn_C == "", "churn_C"] <- "X"
  data[data$churn_D == "", "churn_D"] <- "X"
  data[data$churn_E == "", "churn_E"] <- "X"
  data[data$churn_F == "", "churn_F"] <- "X"
  
  data$churn <- as.factor(data$churn)
  data$churn_A <- as.factor(data$churn_A)
  data$churn_B <- as.factor(data$churn_B)
  data$churn_C <- as.factor(data$churn_C)
  data$churn_D <- as.factor(data$churn_D)
  data$churn_E <- as.factor(data$churn_E)
  data$churn_F <- as.factor(data$churn_F)
  
  return(data)
}

build_predictive_model <- function(independent, data) {
  dependents <- "~ sex + birth + death + enrollment + visits"
  model <- randomForest(
    as.formula(paste(independent, dependents)),
    data = data,
    ntree = 100,
    do.trace = TRUE,
    importance = TRUE
  )
  return(model)
}

print_accuracy <- function(model, data, variable) {
  correct <- data[, variable] == predict(model, data)
  accuracy <- round(sum(correct) / length(correct), 5)
  print(paste("Accuracy for", variable, ":", accuracy))
}

data <- setup_data(data)

#
# Question 1:
#

#
# As can be seen, data is heavily imbalanced towards
# no churn reason (observations with churn == "X")
#
table(data$churn)
table(data$churn_A)
table(data$churn_B)
table(data$churn_C)
table(data$churn_D)
table(data$churn_E)
table(data$churn_F)

# For reproducibility
set.seed(1)

# take 70% of data for training...
select <- sample(1:nrow(data), floor(nrow(data) * 0.7))
data_train <- data[select, ]
data_test <- data[-select, ]

# Accuracy: 0.92579
model <- build_predictive_model("churn", data_train)
print_accuracy(model, data_test, "churn")

# Accuracy: 1.00000
model_A <- build_predictive_model("churn_A", data_train)
print_accuracy(model_A, data_test, "churn_A")

# Accuracy: 1.00000
model_B <- build_predictive_model("churn_B", data_train)
print_accuracy(model_B, data_test, "churn_B")

# Accuracy: 0.99879
model_C <- build_predictive_model("churn_C", data_train)
print_accuracy(model_C, data_test, "churn_C")

# Accuracy: 0.92742
model_D <- build_predictive_model("churn_D", data_train)
print_accuracy(model_D, data_test, "churn_D")

# Accuracy: 0.99949
model_E <- build_predictive_model("churn_E", data_train)
print_accuracy(model_E, data_test, "churn_E")

#
# This churn reason has all 0 values originally, so
# no predictive model can be built for it as we lack
# information for distinguishing among categories
#
# model <- build_predictive_model("churn_F", data_train)
#

# In general, all models show good accuracy, even compared
# to the imbalanced proportions for each independent case.

#
# Question 2:
#
# All accuracy metrics were performed against a test data
# set that was not seen by the algorithm during training.
#
# Accuracy for all churn: 0.92579
# Accuracy for churn A:   1.00000
# Accuracy for churn B:   1.00000
# Accuracy for churn C:   0.99879
# Accuracy for churn D:   0.92742
# Accuracy for churn E:   0.99949

#
# Question 3:
#
# By looking at the Mean Decrease in Gini we can see that,
# in the case of the general model,  the most important
# variable for this Random Forest model is the birth date
# and then visits. Sex, death, and enrollment are less
# important when deciding node purity. Other models have
# different importance magnitudes and orders.
#

varImpPlot(model, type = 2)
varImpPlot(model_A, type = 2)
varImpPlot(model_B, type = 2)
varImpPlot(model_C, type = 2)
varImpPlot(model_D, type = 2)
varImpPlot(model_E, type = 2)
varImpPlot(model_F, type = 2)
