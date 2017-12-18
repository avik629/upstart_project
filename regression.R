#This is a script which needs to be run after the execution.R script. This runs a poission regression on 
#the data table generated at the end of running the custom function at the end of execution.R.

set.seed(629)
# The steps required for regression
table1 <- impact_campaign(acpd, campaigns_no_march$name)
# The randomized version of above
table2 <- table1[sample(nrow(table1)), ]

#Split into regression & validation tables
table2_model <- table2[1:round(nrow(table2) / 2), ]
table2_valid <- table2[-(1:round(nrow(table2) / 2)), ]

#poisson regression
fit2 <- glm(formula = no_of_applicants ~ sent_size + days_since_delivery, family = poisson(link = "log"), data = table2_model)
summary(fit2)