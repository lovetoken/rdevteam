#' Network plot about First & Second relation search words return on Naver
#'
#' Network plot about First & Second relation search words return on Naver
#' @param input a character; search keyword
#' @export
#' @examples
#' nvrGraph("keyword")

nvrGraph <- function(input){

  stopifnot(is.character(input), require(reshape2), require(igraph))

  d1 <- naverRelation1(input)
  df <- naverRelation2(input)
  d2 <- data.frame(R1 = input, R2 = d1)
  df_union <- rbind(d2, df)
  saveHistory(df_union)

  df_g <- graph.data.frame(df_union)

  V(df_g)$label.cex <- ifelse(V(df_g)$name == input, 2,
                              ifelse(V(df_g)$name %in% d1, 1, 0.7))
  colbar <- rainbow(length(d1) + 1)
  V(df_g)$label.color <- ifelse(input == V(df_g)$name, "red",
                                ifelse(V(df_g)$name %in% d1, colbar, "gray50"))
  V(df_g)$label.font <- ifelse(input == V(df_g)$name, 2,
                               ifelse(V(df_g)$name %in% d1, 2, 1))

  ## Source: http://stackoverflow.com/a/28722680/496488
  layout.by.attr <- function(graph, wc, cluster.strength = 1, layout = layout.auto) {
    g <- graph.edgelist(get.edgelist(graph))
    E(g)$weight <- 1

    attr <- cbind(id=1:vcount(g), val=wc)
    g <- g +  igraph::edges(unlist(t(attr)), weight=cluster.strength)

    l <- layout(g, weights=E(g)$weight)[1:vcount(graph),]
    return(l)
  }

  plot(df_g,
       layout = layout.by.attr(df_g, wc = 1, cluster.strength = 1),
       vertex.shape = "none", edge.arrow.size = 0.3, edge.width = 1.5, edge.color = "gray80",
       main = paste("Network plot of", input))

}
