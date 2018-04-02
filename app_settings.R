## Name the Color App
## author: D.Kisler <admin@dkisler.de>
# App settings
suppressPackageStartupMessages({
  library(dplyr, verbose = F, warn.conflicts = F, quietly = T)
  library(magrittr, verbose = F, warn.conflicts = F, quietly = T)
  library(data.table, verbose = F, warn.conflicts = F, quietly = T)
  library(shiny, verbose = F, warn.conflicts = F, quietly = T)
  library(shinyBS, verbose = F, warn.conflicts = F, quietly = T)
  library(shinydashboard, verbose = F, warn.conflicts = F, quietly = T)
  library(shinyjs, verbose = F, warn.conflicts = F, quietly = T)
  library(colourpicker, verbose = F, warn.conflicts = F, quietly = T)
})
#
source('ui.R')