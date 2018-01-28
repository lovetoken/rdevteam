#' First relation search words return on Naver
#'
#' First relation search words return on Naver
#' @param x a character of search keyword
#' @return a vector; character type
#' @export
#' @examples
#' naverRelation1("korea")
#' naverRelation1("apple")

naverRelation1 <- function(x){

  stopifnot(is.character(x),
            require(rvest), require(stringr), require(lava))

  res <- paste0("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=", x) %>%
    read_html %>%
    html_nodes(css = ".lst_relate") %>%
    html_text %>%
    trim %>%
    str_split("   ") %>%
    unlist

  return(res)

}

#' First & Second relation search words return on Naver
#'
#' First & Second relation search words return on Naver
#' @param x a character of search keyword
#' @return tibble type data.frame
#' @export
#' @examples
#' naverRelation2("banana")

naverRelation2 <- function(x){

  stopifnot(is.character(x),
            require(rvest), require(stringr), require(lava), require(dplyr), require(reshape2))

  html <- paste0("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=", x) %>%
    read_html %>%
    html_nodes(css = ".lst_relate") %>%
    html_text %>%
    trim %>%
    str_split("   ") %>%
    unlist

  html2 <- list()
  for(i in html) html2[[i]] <- naverRelation1(i)

  res <- html2 %>%
    lapply(FUN = function(x) gsub(paste0("\\b", x, "\\b", "|", "^", x, " ", "| ", x, "$"), "", x = x)) %>%
    melt %>%
    select(R1 = L1, R2 = value) %>%
    dplyr::filter(R2 != "") %>%
    tbl_df

  return(res)
}
