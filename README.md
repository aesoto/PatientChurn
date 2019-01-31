# PatientChurn
Estimates patient churn

Patient churn is when a patient or beneficiary leaves a health plan. There are multiple reasons why a patient may exit the plan. The following features are provided at a patient level.

ID - Uniquely identifies a patient

Sex - 1 is male, 2 is female

Birth Year - the year of birth

Death Year - the year of death

Assignment Step Flag - whether the patient was enrolled by primary care (1) or a specialist (2)

Count of Primary Care Services - the number of primary care visits in 2015

Indicator variables for the following reasons for churn in 2015. They are 1 if the beneficiary left the plan for that reason and 0 otherwise:

Beneficiary had a date of death prior to the start of the benchmark year

Beneficiary identifier is missing

Beneficiary had at least one month of Part A-only Or Part B-only Coverage

Beneficiary had at least one month in a Medicare Health Plan

Beneficiary does not reside in the United States

Beneficiary included in other Shared Savings Initiatives

The data file is Patient_Churn.csv

QUESTIONS:
1. Build a predictive model to predict the reason for churn. Choose an error measure to assess the predictive accuracy. Provide the model results and code.
2. What is the predictive accuracy of the model? Is it fair to include all of these variables or are there any variables that you would eliminate? 
3. What are the significant variables for predicting if a patient will churn? Are they different based on the different churn reasons?
