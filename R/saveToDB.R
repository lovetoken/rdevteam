#' Save and Load relation search words to sqlite
#'
#' Save and Load relation search words to sqlite
#' @param x return to \code{naverRelation2()} object
#' @export
#' @examples
#' res <- naverRelation2("Keyword")
#' saveHistory(res)
#' loadHistory()

saveHistory <- function(x){

  stopifnot(require(RSQLite))

  time <- Sys.time() %>%
    format(format = "%Y%m%d%H%M%S") %>%
    as.character
  result <- data.frame(regDate = time, x)

  con <- dbConnect(SQLite(), "nvrHistory.sqlite")
  dbWriteTable(con, "nvrHistory", result, append = TRUE)
  dbDisconnect(con)

  message("Success save into DB")

}

#' @export
#' @rdname saveHistory

loadHistory <- function(){

  stopifnot(require(RSQLite))

  con <- dbConnect(SQLite(), "nvrHistory.sqlite")
  res <- dbGetQuery(con, "select * from nvrHistory") %>% tbl_df
  dbDisconnect(con)

  return(res)

}
