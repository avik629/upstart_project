#This script is used to generate a seperate table with the following columns - campaign_name, sent_size,
#days_since_delivery, no_of_applicants. This is used to generate the response table to run a poission
#regression on.

impact_campaign <- function(main_table, list_campaigns){
  result_table <- data.frame()
  for (camp in list_campaigns){
    #print(camp)
    campaign_subset <- main_table[main_table$campaign_name == camp,]
    result_table_subset <- aggregate(campaign_subset$days_since_delivery, by=list(days_since_delivery = campaign_subset$days_since_delivery), FUN=length)
    result_table_subset <- within(result_table_subset, sent_size <- campaign_subset[1, "size_k"])
    result_table_subset <- within(result_table_subset, campaign_name <- campaign_subset[1, "campaign_name"])
    result_table <- rbind(result_table, result_table_subset)
  }
  names(result_table)[names(result_table) == "x"] <- "no_of_applicants"
  setcolorder(result_table, c('campaign_name', "sent_size", "days_since_delivery", "no_of_applicants"))
  return(result_table)
}