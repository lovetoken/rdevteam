#' Network plot about preprocessed naverRelation2 result
#'
#' Network plot about preprocessed naverRelation2 result
#' @param x return to \code{naverRelation2()} object
#' @export
#' @examples
#' networkPlot(naverRelation2("korea"))

networkPlot <- function(x){

  stopifnot(require(ggplot2), require(igraph), require(ggraph), require(grid))

  pre <- x %>%
    count(R2, R1) %>%
    graph_from_data_frame

  res <- pre %>% ggraph(layout = "auto") +
    geom_edge_link(aes(edge_alpha = n*100),
                   arrow = grid::arrow(type = "closed", length = unit(.15, "inches")),
                   end_cap = circle(.07, "inches"), show.legend = F) +
    geom_node_point(color = "lightblue", size = 5) +
    geom_node_text(aes(label = name), vjust = 1, hjust = 0.5) +
    theme_void()

  return(res)
}
