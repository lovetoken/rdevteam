Install
-------

    devtools::install_github("lovetoken/rdevteam")
    library(rdevteam)

<br><br>

주요기능
--------

### 네이버 연관검색어 추출 : `naverRelation()`

    ex1 <- naverRelation("한국", 1)
    ex2 <- naverRelation("한국", 2)

    ex1

    ## # A tibble: 20 x 2
    ##    R0    R1           
    ##    <chr> <chr>        
    ##  1 한국  일본         
    ##  2 한국  미국         
    ##  3 한국  북한         
    ##  4 한국  영국         
    ##  5 한국  러시아       
    ##  6 한국  한국 한자    
    ##  7 한국  인도         
    ##  8 한국  독일         
    ##  9 한국  대만         
    ## 10 한국  캐나다       
    ## 11 한국  베트남       
    ## 12 한국  세계 GDP 순위
    ## 13 한국  프랑스       
    ## 14 한국  호주         
    ## 15 한국  태국         
    ## 16 한국  스페인       
    ## 17 한국  gdp          
    ## 18 한국  한국 축구    
    ## 19 한국  남한         
    ## 20 한국  스위스

    ex2

    ## # A tibble: 400 x 3
    ##    R0    R1    R2       
    ##    <chr> <chr> <chr>    
    ##  1 한국  일본  미국     
    ##  2 한국  일본  대한민국 
    ##  3 한국  일본  한국     
    ##  4 한국  일본  일본지도 
    ##  5 한국  일본  일본 환율
    ##  6 한국  일본  영국     
    ##  7 한국  일본  독일     
    ##  8 한국  일본  러시아   
    ##  9 한국  일본  프랑스   
    ## 10 한국  일본  인도     
    ## # ... with 390 more rows

    plot(ex2)

![](image/plot_ex2.png)

<br><br>

License
-------

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
