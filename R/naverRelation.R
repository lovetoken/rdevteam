#' Naver 연관검색어 추출
#' @description 특정 키워드를 입력하여 실행하면 그 키워드를 기준으로 검색되는 네이버 연관검색어가 벡터형으로 반환됩니다.
#' @param x a character
#' @export
#' @examples
#' naverRelation("한국")

naverRelation <- function(x){

  # Pre
  stopifnot(is.character(x))
  stopifnot(require(RCurl)); stopifnot(require(XML))

  # Content
  html <- paste0('https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=', x) %>%
    read_html %>%
    htmlParse %>%
    capture.output

  relate_tag_pattern <- '<dd class="lst_relate".*?>' # TODO

  # Return
  regmatches(html, regexpr(img_tag_pattern, html))

}
