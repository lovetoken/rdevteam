

  ## network plot for preprocessed naverRelation2 object
  network_plot <- function(x) {
    
    a <- grid::arrow(type = "closed", length = unit(.15, "inches"))
    x %>% ggraph(., layout = "auto") +
      geom_edge_link(aes(edge_alpha = n*100), show.legend = F,
                     arrow = a, end_cap = circle(.07, "inches")) +
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
    
    
  }
  