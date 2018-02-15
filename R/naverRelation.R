#' First & Second relation search words return on Naver.
#'
#' First & Second relation search words return on Naver.
#' @param keyword A character of search keyword.
#' @param depth A number of relation depth you want to see(only 1 or 2).
#' @param searchURL Naver search query.
#' @return tibble type data.frame.
#' @export
#' @examples
#' naverRelation("banana", depth = 2)

naverRelation <- function(keyword, depth = 1, searchURL = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query="){

  if(!depth %in% 1:2) stop("Only 1 or 2 is supported yet for the depth value.")
  stopifnot(is.character(keyword), depth %in% 1:2,
            require(rvest), require(stringr), require(lava), require(dplyr), require(reshape2))

  R1 <- paste0(searchURL, keyword) %>%
    read_html %>%
    html_nodes(css = ".lst_relate") %>%
    html_text %>%
    trim %>%
    str_split("   ") %>%
    unlist

  if(depth == 1){

    res <- tibble(R0 = keyword, R1 = R1)

  } else if(depth == 2){

    depth2 <- list()

    for(i in R1){
      depth2[[i]] <- paste0(searchURL, i) %>%
        read_html %>%
        html_nodes(css = ".lst_relate") %>%
        html_text %>%
        trim %>%
        str_split("   ") %>%
        unlist
    }

    res <- depth2 %>%
      melt %>%
      mutate(R0 = keyword) %>%
      select(R0, R1 = L1, R2 = value) %>% tbl_df

  }

  class(res) <- class(res) %>% append("nr", after = 0)
  attr(res, "depth") <- depth
  return(res)

}
