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
##  [1] "미국"          "일본"          "북한"          "영국"         
##  [5] "러시아"        "인도"          "태국"          "독일"         
##  [9] "대만"          "프랑스"        "캐나다"        "호주"         
## [13] "베트남"        "한국 축구"     "세계 GDP 순위" "스페인"       
## [17] "한국 한자"     "gdp"           "남한"          "필리핀"
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
##  9  미국    브라질
## 10  미국 미국 날씨
## # ... with 370 more rows
```


```r
library(networkD3)

simpleNetwork(ex2)
```

<br>

### 네트워크 시각화 : `nvrGraph()`


```r
nvrGraph("사과")
```

<br><br>

## License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
