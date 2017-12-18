#This is the main script which merges the two tables from the data files about applicants and the other
#one of the campaigns they were exposed to. 

loc_campaigns <- 'D:/Upstart_Project/Campaigns.R' #file location of campaigns script
loc_applicants <- 'D:/Upstart_Project/Applicants.R' #file location of Applicants script
loc_functions <- 'D:/Upstart_Project/functions.R' #file location of functions script


library(lattice)
library(data.table)
source(loc_campaigns)
source(loc_applicants)
source(loc_functions)

#merging the two tables and removing data of historical campaigns we dont have data on
applicants_campaign <- merge(applicants, campaign, by.x = "campaign_name", by.y = "name", all.x = FALSE)
applicants_campaign <- within(applicants_campaign, days_since_delivery <- applicants_campaign$date_application - applicants_campaign$delivery_date)
applicants_campaign$days_since_delivery <- as.numeric(applicants_campaign$days_since_delivery)
acpd <- applicants_campaign[applicants_campaign$days_since_delivery >= 0,] #removing data of responses received before delivery of mail
acpd <- droplevels(acpd)

#code below provides a way to visualize the response % by month
histogram(acpd$days_since_delivery, breaks = seq(0, 700, by = 30), xlab = "Days since delivery", xlim = c(0,120))

#code generates a table of all historical responses as a funtion of time
br <- seq(0,660, by = 30)
ranges <- paste(head(br,-1), br[-1], sep=" - ")
freq <- hist(acpd$days_since_delivery, breaks=br, include.lowest=TRUE, plot=FALSE)
response_table <- data.frame(range = ranges, frequency = freq$counts)
response_table <- within(response_table, percentage <- round(response_table$frequency / sum(response_table$frequency) * 100, 2))
response_table <- within(response_table,cum_percentage <- cumsum(response_table$percentage))
response_table
