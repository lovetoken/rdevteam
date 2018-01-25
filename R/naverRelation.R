#' Naver 1차 연관검색어 추출
#'
#' 특정 키워드를 입력하여 실행하면 그 키워드를 기준으로 검색되는 네이버 연관검색어가 벡터형으로 반환됩니다.
#' @param x 키워드를 캐릭터 형식으로 입력합니다
#' @export
#' @examples
#' naverRelation1("한국")
#' naverRelation1("사과")

naverRelation1 <- function(x){

  ## Pre
  stopifnot(is.character(x),
            require(rvest), require(stringr), require(lava))

  ## Content
  html <- paste0('https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=', x) %>%
    read_html %>%
    html_nodes(css = '.lst_relate') %>%
    html_text %>%
    trim %>%
    str_split('   ') %>%
    unlist

  return(html)

}

#' Naver 2차 연관검색어 추출
#'
#' 특정 키워드를 입력하여 실행하면 그 키워드를 기준으로 검색되는 네이버 연관검색어가 2차 연관검색어까지 데이터프레임 형태로 반환됩니다.
#' @param x 키워드를 캐릭터 형식으로 입력합니다
#' @export
#' @return tibble type data.frame
#' @examples
#' data(example_keywords)
#'
#' example_keywords[1, 2] %>%
#'   pull %>%
#'   naverRelation2

naverRelation2 <- function(x){

  ## Pre
  stopifnot(is.character(x),
            require(rvest), require(stringr), require(lava), require(dplyr), require(reshape2))

  ## Content
  html <- paste0('https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=', x) %>%
    read_html %>%
    html_nodes(css = '.lst_relate') %>%
    html_text %>%
    trim %>%
    str_split('   ') %>%
    unlist

  html2 <- list()
  for(i in html) html2[[i]] <- naverRelation1(i)

  pre <- html2 %>%
    lapply(FUN = function(x) gsub(paste0("\\b", x, "\\b", "|", "^", x, " ", "| ", x, "$"), "", x = x)) %>%
    melt %>% tbl_df %>%
    select(R1 = L1, R2 = value) %>%
    dplyr::filter(R2 != "")

  return(pre)
}
