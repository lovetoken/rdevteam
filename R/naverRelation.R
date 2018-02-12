#' First & Second relation search words return on Naver.
#'
#' First & Second relation search words return on Naver.
#' @param keyword A character of search keyword.
#' @param depth A number of relation depth you want to see(1 or 2).
#' @return tibble type data.frame.
#' @export
#' @examples
#' naverRelation("banana", depth = 2)

naverRelation <- function(keyword, depth = 1){
  
  stopifnot(is.character(keyword),
            require(rvest), require(stringr), require(lava), require(dplyr), require(reshape2))
  
  R1 <- paste0("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=", keyword) %>%
    read_html %>%
    html_nodes(css = ".lst_relate") %>%
    html_text %>%
    trim %>%
    str_split("   ") %>%
    unlist

  if(depth == 1){
    R1 <- tibble(R0 = keyword, R1 = R1)
    class(R1) <- c("nr", "tbl_df", "tbl", "data.frame")
    return(R1)

  }else if(depth == 2){
    depth2 <- list()
    
    for(i in R1) {
      depth2[[i]] <- naverRelation1(i)
    }
    
    R2 <- depth2 %>%
      melt %>%
      mutate(R0 = keyword) %>%
      apply(., 2, as.character) %>%
      tbl_df %>%
      select(R0, R1 = L1, R2 = value)
    class(R2) <- c("nr", "tbl_df", "tbl", "data.frame")
    return(R2)
    
  }else{
    message("Only 1 or 2 is supported yet for the depth value.")
  }

}

