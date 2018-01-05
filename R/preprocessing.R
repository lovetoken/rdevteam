

  #install.packages("devtools")
  devtools::install_github("lovetoken/rdevteam")
  library(rdevteam)
  pacman::p_load('reshape2', 'igraph', 'rdevteam', 'ggraph',
                 'tidytext', 'tidyr', 'dplyr', 'data.table',
                 'rdevteam')

  ## loading sub functions
  source("function_network_plot.R")

  ## input condition
  input <- "사과"

  ## loading data
  df <- naverRelation2(input)

  ## preprocessed data
  pre <- df %>%
    lapply(., FUN = function(x) {
      gsub(pattern = paste0("\\b",input,"\\b","|","^",input," ","| ",input,"$"),
           replacement = "", x=x)
      }) %>%
    melt %>% select(L1,value) %>%
    filter(value != "")

  ## network object
  network_graph <- pre %>%
    count(.,value, L1) %>%
    graph_from_data_frame

  ## network plotting
  network_graph %>% network_plot

