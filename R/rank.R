#' Real-time search words ranking return on Naver.
#'
#' Real-time search words ranking return on Naver.
#' @param depth A number of relation depth you want to see(only 1 or 2).
#' @param searchURL Naver Real-time search ranking query.
#' @return tibble type data.frame.
#' @export
#' @examples
#' naverRank(depth = 2)
#'

naverRank <- function(depth = 1, searchURL = "https://datalab.naver.com/keyword/realtimeList.naver"){

  if(!depth %in% 1:2) stop("Only 1 or 2 is supported yet for the depth value.")
  stopifnot(depth %in% 1:2,
            require(rvest), require(stringr), require(lava), require(dplyr), require(reshape2))

  time <- as.character(Sys.time())

  R1 <- searchURL %>%
    read_html %>%
    html_nodes(css = ".title") %>%
    html_text %>%
    trim %>%
    str_split("   ") %>%
    unlist

  R1 <- R1[81:100]

  if(depth == 1){

    res <- tibble(R0 = time, R1 = R1)

  } else if(depth == 2){

    depth2 <- list()

    for(i in R1){
      depth2[[i]] <- paste0("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=", i) %>%
        read_html %>%
        html_nodes(css = ".lst_relate") %>%
        html_text %>%
        trim %>%
        str_split("   ") %>%
        unlist
    }

    res <- depth2 %>%
      melt %>%
      mutate(R0 = time) %>%
      select(R0, R1 = L1, R2 = value) %>% tbl_df

  }

  class(res) <- class(res) %>% append("nr", after = 0)
  return(res)

}
