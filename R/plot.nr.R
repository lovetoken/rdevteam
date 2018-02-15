#' Network plot about preprocessed naverRelation result
#'
#' Network plot about preprocessed naverRelation result
#' @param x return to \code{naverRelation()} object
#' @export
#' @examples
#' nr1 <- naverRelation("korea", 1)
#' plot(nr1)
#'
#' nr2 <- naverRelation("korea", 2)
#' plot(nr2)

plot.nr <- function(x){

  stopifnot(require(igraph), require(networkD3), require(dplyr))

  if(attributes(x)$depth == 1){

    pre <- x %>%
      count(R1, R0) %>%
      graph_from_data_frame %>%
      igraph_to_networkD3

    pre$nodes$group <- ifelse(pre$nodes$name %in% x$R0, "Keyword", "1st Relation")

    return(
      networkD3::forceNetwork(Links = pre$links, Nodes = pre$nodes,
                              colourScale = JS("d3.scaleOrdinal(d3.schemeCategory10);"),
                              Source = "source", Target = "target",
                              Value = "value", NodeID = "name",
                              Group = "group", opacity = 0.9, zoom = T,
                              fontSize = 20, fontFamily = "serif", legend = T,
                              opacityNoHover = 0.1)
    )

  } else if(attributes(x)$depth == 2){

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
      networkD3::forceNetwork(Links = pre$links, Nodes = pre$nodes,
                              colourScale = JS("d3.scaleOrdinal(d3.schemeCategory10);"),
                              Source = "source", Target = "target",
                              Value = "value", NodeID = "name",
                              Group = "group", opacity = 0.9, zoom = T,
                              fontSize = 20, fontFamily = "serif", legend = T,
                              opacityNoHover = 0.1)
    )

  }

}
