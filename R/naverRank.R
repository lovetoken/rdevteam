#' Real-time search words ranking return on Naver.
#'
#' Real-time search words ranking return on Naver.
#' @param searchURL Naver Real-time search ranking query.
#' @return tibble type data.frame.
#' @export
#' @examples
#' naverRank()

naverRank <- function(searchURL = "https://datalab.naver.com/keyword/realtimeList.naver"){

  stopifnot(require(rvest), require(lava), require(dplyr), require(reshape2), require(magrittr))

  top20 <- searchURL %>%
    read_html %>%
    html_nodes(css = ".title") %>%
    html_text %>%
    trim %>%
    extract(81:100)

  res <- tibble(search_time = as.character(Sys.time()), top_keyword = top20)
  class(res) <- class(res) %>% append("nr", after = 0)
  return(res)

}
