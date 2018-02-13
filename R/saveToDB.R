#' Save and Load relation search words to sqlite
#'
#' Save and Load relation search words to sqlite
#' @param x return to \code{naverRelation2()} object
#' @export
#' @examples
#' relation <- naverRelation("Keyword", 2)
#' saveHistory(relation)
#' loadHistory()

saveHistory <- function(x){

  stopifnot(require(RSQLite))

  time <- Sys.time() %>%
    format(format = "%Y%m%d%H%M%S") %>%
    as.character
  result <- x %>%
    mutate(regDate = time) %>%
    select(regDate, everything())

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
