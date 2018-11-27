#' Real-time search words ranking return on Naver.
#'
#' Real-time search words ranking return on Naver.
#' @param searchURL Naver Real-time search ranking query.
#' @return tibble type data.frame.
#' @export
#' @examples
#' naverRank()

naverRank <- function(searchURL = "https://www.naver.com"){
  top20 <- xml2::read_html(searchURL) %>%
    rvest::html_nodes(".ah_a") %>%
    rvest::html_text() %>%
    stringr::str_replace_all("[\n[0-9]\n]", "")
  
  top20 <- top20[seq(1:20)]
  
  res <- tibble::tibble(search_time = as.character(Sys.time()), top_keyword = top20)
  class(res) <- class(res) %>%
    append("nr", after = 0)
  return(res)
}
