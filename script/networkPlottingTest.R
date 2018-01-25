#install.packages("devtools")
devtools::install_github("lovetoken/rdevteam")
pacman::p_load('reshape2', 'igraph', 'rdevteam', 'ggraph',
               'tidytext', 'tidyr', 'dplyr', 'data.table',
               'rdevteam')

library(igraph)
library(rdevteam)
library(networkD3)

## input condition
input <- "아이폰"

## loading data
d1 <- naverRelation1(input)
df <- naverRelation2(input)

## preprocessed data
d2 <- data.frame(R1 = input, R2 = d1)
df_union <- rbind(d2, df)


## network object
df_g <- graph.data.frame(df_union)
V(df_g)$color <- ifelse(input == V(df_g)$name, "red",  "yellow")
V(df_g)$label.cex <- 0.7

## network plotting
plot(df_g, vertex.size= 4 , edge.arrow.size=0.2, edge.width=1, main = paste0(input, "의 연관검색네트워크"))
simpleNetwork(df_union)
# 참고자료: http://christophergandrud.github.io/networkD3/
