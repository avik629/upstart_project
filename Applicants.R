#This script simply takes a csv file of the data of applicants as formated in the example and re-assigns
#the data types to be workable in R

applicants <- read.csv(file = "D:/Upstart_Project/170228 1230 DM applicants_shared.csv", header = TRUE)
colnames(applicants) <- c("id", "zip", "edu1","edu1_year", "edu2","edu2_year", "edu3","edu3_year", "number_degrees", "date_application", "date_funded", "status", "campaign_name")
applicants$date_application <- as.Date(applicants$date_application, "%m/%d/%Y %H:%M")
