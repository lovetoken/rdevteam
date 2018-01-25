#' 연관 검색 히스토리와 결과를 저장 및 로드하는 함수
#'
#' 네이버 연관 검색어로 조회하였을 때 조회 히스토리를 DB로 저장하고 로드하는 함수입니다.
#' @param df \code{naverRelation2()} 함수를 통해 반환된 데이터프레임 타입 결과를 입력합니다.
#' @export
#' @examples
#' res <- naverRelation2("Keyword")
#' saveHistory(res)
#' loadHistory()

saveHistory <- function(df){

  ## Pre
  stopifnot(require(RSQLite))

  ## Content
  time <- Sys.time() %>%
    format(format = "%Y%m%d%H%M%S") %>%
    as.character
  result <- data.frame(regDate = time, df)

  con <- dbConnect(SQLite(), "nvrHistory.sqlite")
  dbWriteTable(con, "nvrHistory", result, append = TRUE)
  dbDisconnect(con)

  message("Success save into DB")

}

#' @rdname saveHistory
#'
#' @export

loadHistory <- function(){

  ## Pre
  stopifnot(require(RSQLite))

  ## Content
  con <- dbConnect(SQLite(), "nvrHistory.sqlite")
  result <- dbGetQuery(con, "select * from nvrHistory") %>% tbl_df
  dbDisconnect(con)

  return(result)

}
