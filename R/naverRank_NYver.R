#' Real-time search words ranking return on Naver.
#'
#' Real-time search words ranking return on Naver.
#' @param depth A number of relation depth you want to see(only 1 or 2).
#' @param searchURL Naver Real-time search ranking query.
#' @return tibble type data.frame.
#' @export
#' @examples
#' naverRank(depth = 2)
#'

naverRank <- function(depth = 1, searchURL = "https://datalab.naver.com/keyword/realtimeList.naver"){

  if(!depth %in% 1:2) stop("Only 1 or 2 is supported yet for the depth value.")
  stopifnot(depth %in% 1:2,
            require(rvest), require(stringr), require(lava), require(dplyr), require(reshape2))

  time <- as.character(Sys.time())

  R1 <- searchURL %>%
    read_html %>%
    html_nodes(css = ".title") %>%
    html_text %>%
    trim %>%
    str_split("   ") %>%
    unlist

  R1 <- R1[81:100]

  if(depth == 1){

    res <- tibble(R0 = time, R1 = R1)

  } else if(depth == 2){

    depth2 <- list()

    for(i in R1){
      depth2[[i]] <- paste0("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=", i) %>%
        read_html %>%
        html_nodes(css = ".lst_relate") %>%
        html_text %>%
        trim %>%
        str_split("   ") %>%
        unlist
    }

    res <- depth2 %>%
      melt %>%
      mutate(R0 = time) %>%
      select(R0, R1 = L1, R2 = value) %>% tbl_df

  }

  class(res) <- class(res) %>% append("nr", after = 0)
  return(res)

}





naverRankDay(date="2017-02-27"){

  library(lubridate)
  library(stringr)
  library(dplyr)
  library(rvest)
  library(lava)
  library(reshape2)
  library(magrittr)

  if(!depth %in% 1:2) stop("Only 1 or 2 is supported yet for the depth value.")
  stopifnot(depth %in% 1:2,
            require(),require(rvest), require(stringr), require(lava), require(dplyr), require(reshape2))

  date <- "2018-02-27"
  res <- tibble(time=rep(NA,(24*60*2*20)),rank=rep(1:20,(24*60*2)),top_keyword=rep(NA,(24*60*2*20)))

  for(i in 0:((24*60*60)/30)){

    time <- ymd_hms("2018-02-27 00:00:30") + seconds(30*i)
    time <- as.character(time)
    time <- str_sub(time,12,19)
    searchURL <- paste0("https://datalab.naver.com/keyword/realtimeList.naver?datetime=",date,"T",time)

    top20 <- searchURL %>%
      read_html %>%
      html_nodes(css = ".title") %>%
      html_text %>%
      trim %>%
      extract(81:100)

    res$time[(1+i*20):(20*(i+1))] <- time
    res$top_keyword[(1+i*20):(20*(i+1))] <- top20

  }

  class(res) <- class(res) %>% append("nr", after = 0)
  return(res)
}



library(ggplot2)
library(plotly)
library(dplyr)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(stringr)

#WORDCLOUD
wc <- res
wc <- Corpus(VectorSource(wc$top_keyword))
guess_encoding(wc)
wc_encoding <- iconv(wc,"EUC-KR","UTF-8")
guess_encoding(wc_encoding)

tdm_wc<-TermDocumentMatrix(wc_encoding) #Creates a TDM
TDM1<-as.matrix(tdm_wc) #Convert this into a matrix format
v = sort(rowSums(TDM1), decreasing = TRUE) #Gives you the frequencies for every word

wordcloud(wc, max.words = Inf, min.freq = 1, random.order = FALSE, rot.per = 0.1, colors = brewer.pal(8, "Dark2"))

## Term-Document
dtm <- TermDocumentMatrix(wc_data)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
d

