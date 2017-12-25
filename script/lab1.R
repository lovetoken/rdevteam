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

dir.create("output")
relation <- naverRelation2(args)
relation %>%
  toJSON(pretty = T) %>%
  write_json("output/lab1_result.json")
