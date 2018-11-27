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
#' naverRelation("훈민정음", depth = 2)

naverRelation <- function(keyword, depth = 1, searchURL = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query="){
  if(!depth %in% 1:2) stop("Only 1 or 2 is supported yet for the depth value.")
  stopifnot(is.character(keyword), depth %in% 1:2)

  unicode_keyword <- paste0("%", charToRaw(keyword), collapse = "")
  R1 <- paste0(searchURL, unicode_keyword) %>%
    xml2::read_html() %>%
    rvest::html_nodes(css = ".lst_relate") %>%
    rvest::html_text() %>%
    trimws("both") %>%
    stringr::str_split("   ") %>%
    unlist()

  if(depth == 1) res <- tibble::tibble(R0 = keyword, R1 = R1) else if(depth == 2){

    depth2 <- list()

    for(i in R1){
      unicode_keyword <- paste0("%", charToRaw(i), collapse = "")
      depth2[[i]] <- paste0(searchURL, unicode_keyword) %>%
        xml2::read_html() %>%
        rvest::html_nodes(css = ".lst_relate") %>%
        rvest::html_text() %>%
        trimws("both") %>%
        stringr::str_split("   ") %>%
        unlist()
    }

    res <- depth2 %>%
      reshape2::melt() %>%
      dplyr::mutate(R0 = keyword) %>%
      dplyr::select(R0, R1 = L1, R2 = value) %>%
      tbl_df

  }

  class(res) <- class(res) %>%
    append("nr", after = 0)
  attr(res, "depth") <- depth
  return(res)
}
