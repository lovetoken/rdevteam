#' Network plot about preprocessed naverRelation2 result
#'
#' Network plot about preprocessed naverRelation2 result
#' @param x return to \code{naverRelation2()} object
#' @export
#' @examples
#' networkPlot_3d(naverRelation2("korea"))

  networkplot_3d <- function(x){
    
    stopifnot(require(igraph), require(networkD3), require(dplyr))
    
    x1 <- x[,1:2]; colnames(x1) <- c("R1", "R2")
    x2 <- x[,2:3]; colnames(x2) <- c("R1", "R2")
    new_x <- rbind(x1, x2)
    
    pre <- new_x %>%
      count(R2, R1) %>%
      graph_from_data_frame %>%
      igraph_to_networkD3
    
    pre$nodes$group <- ifelse(pre$nodes$name %in% x$R0, "Keyword",
                              ifelse(pre$nodes$name %in% x$R1, "1st Relation", "2nd Relation"))
    
    return(
      
      forceNetwork(Links = pre$links, Nodes = pre$nodes,
                   colourScale = JS("d3.scaleOrdinal(d3.schemeCategory10);"),
                   Source = "source", Target = "target",
                   Value = "value", NodeID = "name",
                   Group = "group", opacity = 0.9, zoom = T,
                   fontSize = 20, fontFamily = "serif", legend = T)
      
    )

}