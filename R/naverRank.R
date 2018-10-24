#' Real-time search words ranking return on Naver.
#'
#' Real-time search words ranking return on Naver.
#' @param searchURL Naver Real-time search ranking query.
#' @return tibble type data.frame.
#' @export
#' @examples
#' naverRank()

naverRank <- function(searchURL = "https://datalab.naver.com/keyword/realtimeList.naver"){
  top20 <- xml2::read_html(searchURL) %>%
    rvest::html_nodes(css = ".title") %>%
    rvest::html_text() %>%
    trimws("both") %>%
    magrittr::extract(81:100)

  res <- tibble::tibble(search_time = as.character(Sys.time()), top_keyword = top20)
  class(res) <- class(res) %>%
    append("nr", after = 0)
  return(res)
}
