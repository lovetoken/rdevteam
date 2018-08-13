#' Save and Load relation search words to sqlite
#'
#' Save and Load relation search words to sqlite
#' @param x return to \code{naverRelation()} object
#' @param path save fileDB path
#' @export
#' @examples
#' relation <- naverRelation("Keyword", 2)
#' saveHistory(relation)
#' loadHistory()

saveHistory <- function(x, path = "nvrHistory.sqlite"){
  time <- format(Sys.time(), format = "%Y%m%d%H%M%S") %>%
    as.character()
  result <- x %>%
    dplyr::mutate(regDate = time, depth = as.integer(attributes(.)$depth)) %>%
    dplyr::select(regDate, tidyselect::everything())

  con <- DBI::dbConnect(RSQLite::SQLite(), path)
  DBI::dbWriteTable(con, "nvrHistory", result, append = T)
  DBI::dbDisconnect(con)
  message("Success save into DB")
}

#' @export
#' @rdname saveHistory

loadHistory <- function(){
  con <- DBI::dbConnect(RSQLite::SQLite(), "nvrHistory.sqlite")
  res <- DBI::dbGetQuery(con, "select * from nvrHistory")
  DBI::dbDisconnect(con)

  class(res) <- class(res) %>%
    append("nr", after = 0)
  attr(res, "depth") <- grep("R[^0]", colnames(res)) %>% length()
  return(dplyr::tbl_df(res))
}
