---
title: README
author: <a href = "https://lovetoken.gitbooks.io/r-dev-team-open-seminar/content/">R Dev Team</a>
date: "2017-12-25"
output: 
  html_document:
    fig_height: 6
    theme: yeti
    toc: yes
    toc_depth: 3
    toc_float: yes
    keep_md: yes
---



<br><br>

## Install


```r
devtools::install_github("lovetoken/rdevteam")
library(rdevteam)
```

<br><br>

## 주요기능

### 네이버 연관검색어 추출 : `naverRelation1()`, `naverRelation2()`


```r
naverRelation1("한국")
```

```
##  [1] "미국"          "러시아"        "영국"          "인도"         
##  [5] "가나"          "핀란드"        "프랑스"        "태국"         
##  [9] "캐나다"        "세계 GDP 순위" "대만"          "호주"         
## [13] "베트남"        "한국 한자"     "gdp"           "이탈리아"     
## [17] "필리핀"        "남한"          "인도네시아"    "스페인"
```

```r
naverRelation2("한국")
```

```
## # A tibble: 380 x 2
##       R1            R2
##    <chr>         <chr>
##  1  미국      대한민국
##  2  미국          한국
##  3  미국          영국
##  4  미국          인도
##  5  미국        캐나다
##  6  미국          독일
##  7  미국        프랑스
##  8  미국          호주
##  9  미국        브라질
## 10  미국 세계 GDP 순위
## # ... with 370 more rows
```

### 네트워크 시각화 : `networkPlot()`


```r
library(dplyr)
library(igraph)

network_graph <- naverRelation2("한국") %>%
  count(R2, R1) %>%
  graph_from_data_frame
  
networkPlot(network_graph)
```

