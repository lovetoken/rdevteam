#' 연관 검색 히스토리와 결과를 저장하는 함수
#' @description 네이버 연관 검색어로 조회하였을 때 조회 히스토리를 DB로 저장하는 함수입니다.
#' @param df 키워드를 데이터프레임 형식으로 저장합니다.
#' @export
#' @examples
#' saveHistory(df)
#' loadHistory()


saveHistory <- function(df){
  library(RSQLite)

  # DB 접속
  con <- dbConnect(SQLite(), "nvrHistory.sqlite")

  now <- Sys.time()
  time <- as.character(format(now, format = "%Y%m%d%H%M%S"))
  result <- data.frame(regDate = time, df)

  # DB에 데이터 프레임 기록하기
  # DB에 저장되는 형태는 데이터 프레임과 유사
  dbWriteTable(con, "nvrHistory", result, append = TRUE)

  # DB연결 종료
  dbDisconnect(con)
  print("저장하였습니다.")

}

loadHistory <- function(){
  library(RSQLite)
  # DB 연결
  con <- dbConnect(SQLite(), "nvrHistory.sqlite")

  # DB에서 결과 가져 오기
  result <- dbGetQuery(con, "select * from nvrHistory")

  # DB 연결 종료
  dbDisconnect(con)
  return(result)
  print("로드하였습니다.")
}

loadHistory()
