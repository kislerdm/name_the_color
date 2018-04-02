## Name the Color App
## author: D.Kisler <admin@dkisler.de>
# App settings
suppressPackageStartupMessages({
  library(dplyr, verbose = F, warn.conflicts = F, quietly = T)
  library(magrittr, verbose = F, warn.conflicts = F, quietly = T)
  library(shiny, verbose = F, warn.conflicts = F, quietly = T)
  library(shinyBS, verbose = F, warn.conflicts = F, quietly = T)
  library(shinydashboard, verbose = F, warn.conflicts = F, quietly = T)
  library(shinyjs, verbose = F, warn.conflicts = F, quietly = T)
  library(colourpicker, verbose = F, warn.conflicts = F, quietly = T)
  library(jsonlite, verbose = F, warn.conflicts = F, quietly = T)
  library(RPostgreSQL, verbose = F, warn.conflicts = F, quietly = T)
  library(rmarkdown, verbose = F, warn.conflicts = F, quietly = T)
})

## DB connection
credentials <- fromJSON("/home/dkisler/db_credentials.json")

# queries
# fetch data
q_fetch_all_colors <- "select color_name, hex, r, g, b from colors order by 1;"
# insert color
q_add_color <- "insert into colors(color_name, hex, r, g, b) values ('@color_name@', '@hex@', @r@::INT, @g@::INT, @b@::INT);"

## UI
source("ui.R")
