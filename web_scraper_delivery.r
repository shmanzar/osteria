rm(list = ls())
library(httr)
library(rvest)
library(tidyverse)
library(data.table)
library(glue)

# Specify authorisations for  the client's login page and then log in
# I have removed the authorisations due to government regulations on healthcare data and personal bindings to NDAs
login <- list(
    username = 'USERNAME',
    password = 'PASSWORD',
    submit = "Login"
)

period <- "custom_period"
from_date <- "2018-06-01"
to_date <- "2018-06-15"

res <- POST("http://www.CLIENT_URL_COM/mis/index.php?login", body = login, encode = "form", verbose())


# First find all the urls

table_urls <- c(glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=1"), 
                glue( "http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}btnSubmit=Search&page=1&Submit=1&district_id=2"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=3"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=4"),  
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=5"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=6"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=7"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=8"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=9"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=10"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=11"),
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=12"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=13"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=14"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=15"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=16"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=17"),
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=18"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=19"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=20"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=21"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=22"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=23"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=24"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=25"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=26"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=27"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=28"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=29"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=30"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=31"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=32"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=33"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=34"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=35"), 
                glue("http://www.CLIENT_URL_COM?period={period}&from_date={from_date}&to_date={to_date}&btnSubmit=Search&page=1&Submit=1&district_id=36"))



# Then loop over the urls, downloading & extracting the pages

tables_dump <- table_urls %>% map(GET) %>% map(read_html)

# Extracting only the required tables and cleaning added totals and column names

get_df_fromlist <- function(list_of_df, df_loc){
    df_select <- list_of_df[[df_loc]]
    return(df_select)
}

dist_table <- tables_dump %>% map(html_nodes, xpath = '//*[@id="form2"]/table') %>% 
    map(html_table, fill = TRUE) %>%
    map(get_df_fromlist, 1) %>% 
    map(slice, -n()) %>% 
    map(slice, -1)


# Using data.table to bind individual dataframes from the master list of dataframes
nameless_dataset <- rbindlist(dist_table, fill=TRUE)

# Adding column names to the final dataframe and export to csv
names(nameless_dataset) <- c("Month", "Code", "Health Facility Name", "Facility Type", "District", "Total Deliveries")    

#Replacing Sr. column with a Month column denoting the preceding month
## Should change it so that it gets queried from the client's page itself


nameless_dataset <- nameless_dataset %>% 
    mutate(Month = format(as.Date(from_date), "%B"),
           Year = format(as.Date(from_date), "%Y") )


write_csv(nameless_dataset, glue("{format(as.Date(from_date), '%Y_%m')}_Deliveries.csv"))  

