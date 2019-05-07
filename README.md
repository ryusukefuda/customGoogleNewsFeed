# customGoogleNewsFeed

Out put custom google news feed api in Ruby.  
put multiwords google news rss into one.

GoogeNewsFeedを使って複数の固定の単語のニュースを日付順に並び替えた  
APIを出力するRailsプロジェクトです。サンプルでは芸能人を設定しています。

### GET API
 {BASEURL}/parsing/index



    {
      result: true
      status: 200
      body: [{
          "title":
          "article_url":
          "date":
          "name":
        }]
    }

### Parameters  
| Name       | Must | Description                   | Default | Sample |
|:-----------|-----:|:-----------------------------:|:-------:|:------:|
| start      |      | Start position to get article |    0    |   10   |
| count      |      | Number of article             |    10   |   15   |

{BASEURL}/parsing/index?start=5&count=15

### Usage
You can put your words in this line like this.



    persons_entertainers = %w(
                          黒木メイサ
                          新垣結衣
                          瀬戸康史
                          三浦翔平
                          MayJ
                          加藤ミリヤ
                          濱田岳
                          中尾明慶
                          吉高由里子
                          戸田恵梨香
                          徳島えりか
                          福田彩乃
                          松坂桃李
                          豊田エリー
                          清水翔太
                          西野カナ
    )
    persons_athletes = %w(
                    田中将大
                    坂本勇人
                    吉川光夫
                    香川真司
                    吉田麻也
                    乾貴士
                    内村航平
                    福原愛
                    井岡一翔
                    亀山耕平
    )

###Contact
Please contact me on Twitter.
[@ryusukefuda](https://twitter.com/ryusukefuda)
