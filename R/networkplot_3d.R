#' Network plot about preprocessed naverRelation2 result
#'
#' Network plot about preprocessed naverRelation2 result
#' @param x return to \code{naverRelation2()} object
#' @export
#' @examples
#' networkPlot_3d(naverRelation2("korea"))

  networkplot_3d <- function(x){
    
    stopifnot(require(igraph), require(networkD3), require(dplyr))
    
    pre <- x %>%
      count(R2, R1) %>%
      graph_from_data_frame %>%
      igraph_to_networkD3
    
    pre$nodes$group <- as.factor(1:nrow(pre$nodes))
    
    return(
      
      forceNetwork(Links = pre$links, Nodes = pre$nodes,
                   Source = "source", Target = "target",
                   Value = "value", NodeID = "name",
                   Group = "group", opacity = 0.8, zoom = T,
                   fontSize = 20, fontFamily = "serif")
      
    )

}