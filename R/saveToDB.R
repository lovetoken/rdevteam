#' Save and Load relation search words to sqlite
#'
#' Save and Load relation search words to sqlite
#' @param x return to \code{naverRelation2()} object
#' @param path save fileDB path
#' @export
#' @examples
#' relation <- naverRelation("Keyword", 2)
#' saveHistory(relation)
#' loadHistory()

saveHistory <- function(x, path = "nvrHistory.sqlite"){

  stopifnot(require(RSQLite))

  time <- Sys.time() %>%
    format(format = "%Y%m%d%H%M%S") %>%
    as.character
  result <- x %>%
    mutate(regDate = time, depth = as.integer(attributes(.)$depth)) %>%
    select(regDate, everything())

  con <- dbConnect(SQLite(), path)
  dbWriteTable(con, "nvrHistory", result, append = T)
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

  class(res) <- class(res) %>% append("nr", after = 0)
  attr(res, "depth") <- max(res$depth)
  return(res)

}
