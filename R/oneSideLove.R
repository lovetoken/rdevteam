pacman::p_load("dplyr","rdevteam","cowsay")

# 짝사랑 찾기: 2차 연관검색어에 keyword 본인이 존재하는지 알아보는 함수입니다.
oneSideLove <- function(keyword){
  df <- naverRelation2(keyword)
  lenght <- naverRelation1(keyword) %>% length()
  love <- table(df$R2==keyword) %>% as.data.frame()
  oneside <- lenght-love[2,2]
  lovelove <- paste(keyword, "LOVES", love[2,2],"keywords.","A total",oneside,"keywords are one side LOVER.. OTZ")
  say(what=lovelove, by="random")
}

oneSideLove("문재인")

# 서로 검색되는 keyword의 리스트
loveWho <- function(keyword){
  df <- naverRelation2(keyword)
  lover <- filter(df, R2==keyword)[2]
  colnames(lover) <- "LOVER"
  return(lover)
}

loveWho("문재인")
