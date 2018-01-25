#' Network plot for preprocessed naverRelation2 object
#'
#' 2차 연관검색어에 대한 네트워크 시각화 함수입니다.
#' @param x
#' @export
#' @examples
#' network_graph <- naverRelation2("한국") %>%
#'   count(R2, R1) %>%
#'   graph_from_data_frame %>%
#'   networkPlot

networkPlot <- function(x) {

  ## Pre
  stopifnot(require(ggplot2), require(igraph), require(ggraph), require(grid))

  ## Content
  res <- x %>% ggraph(layout = "auto") +
    geom_edge_link(aes(edge_alpha = n*100),
                   arrow = grid::arrow(type = "closed", length = unit(.15, "inches")),
                   end_cap = circle(.07, "inches"), show.legend = F) +
    geom_node_point(color = "lightblue", size = 5) +
    geom_node_text(aes(label = name), vjust = 1, hjust = 0.5) +
    theme(axis.line=element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          legend.position="none",
          #panel.background=element_blank(),
          panel.background=element_rect(colour = "lightgray"),
          panel.border=element_blank(),
          panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          plot.background=element_blank())

  return(res)
}
