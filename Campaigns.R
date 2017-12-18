#This script simply takes a csv file of the data of campaigns as formated in the example and re-assigns
#the data types to be workable in R

campaign <- read.csv(file = "D:/Upstart_Project/170226 1230 DM Campaign delivery dates_shared.csv", header = TRUE)
campaign <- subset(campaign, select = -c(X, X.1, X.2, X.3, X.4)) #removes empty columns from the read operation above
colnames(campaign) <- c("name", "size_k", "delivery_date")
campaign$delivery_date <- as.Date(campaign$delivery_date, "%m/%d/%Y")

#This particular piece of code below removes the march, 2017 campaign data for regression analysis
#purposes
campaigns_no_march <- campaign[campaign$delivery_date < "2017-03-01",]
campaigns_no_march <- droplevels(campaigns_no_march) 