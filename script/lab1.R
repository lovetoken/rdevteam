## Ready packages

library(rdevteam)
library(rvest)
library(stringr)
library(lava)
library(RSQLite)
library(magrittr)
library(jsonlite)

## Argument

args <- commandArgs(TRUE) %>% extract(1)

## Content

try(dir.create("output"), silent = T)
filename <- paste0("output/lab1_result_", args, "_", Sys.Date(), ".json") %>% gsub("-", "", .)
relation <- naverRelation(keyword = args, 2)
relation %>%
  toJSON(pretty = T) %>%
  write_json(path = filename)
