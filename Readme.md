---
title: README
author: <a href = "https://lovetoken.gitbooks.io/r-dev-team-open-seminar/content/">R Dev Team</a>
date: "2018-01-14"
output: 
  html_document:
    fig_height: 6
    theme: yeti
    toc: yes
    toc_depth: 3
    toc_float: yes
    keep_md: yes
---



## Install


```r
devtools::install_github("lovetoken/rdevteam")
library(rdevteam)
```

<br><br>

## 주요기능

### 네이버 연관검색어 추출 : `naverRelation1()`, `naverRelation2()`


```r
ex1 <- naverRelation1("한국")
ex2 <- naverRelation2("한국")

ex1
```

```
##  [1] "미국"          "북한"          "영국"          "러시아"       
##  [5] "인도"          "독일"          "프랑스"        "태국"         
##  [9] "호주"          "베트남"        "스페인"        "대만"         
## [13] "캐나다"        "세계 GDP 순위" "남한"          "gdp"          
## [17] "한국 한자"     "핀란드"        "필리핀"        "인도네시아"
```

```r
ex2
```

```
## # A tibble: 380 x 2
##       R1        R2
##    <chr>     <chr>
##  1  미국      일본
##  2  미국  대한민국
##  3  미국      한국
##  4  미국      영국
##  5  미국    캐나다
##  6  미국      인도
##  7  미국    프랑스
##  8  미국      독일
##  9  미국 미국 날씨
## 10  미국    브라질
## # ... with 370 more rows
```


```r
library(networkD3)

simpleNetwork(ex2)
```

<br>

### 네트워크 시각화 : `networkPlot()`


```r
library(dplyr)
library(igraph)

network_graph <- naverRelation2("한국") %>%
  count(R2, R1) %>%
  graph_from_data_frame

networkPlot(network_graph)
```

<br><br>

## License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
