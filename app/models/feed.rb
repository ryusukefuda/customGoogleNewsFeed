require 'uri'

class Feed

  def parse(start=0, count=10)

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
                          ながと帰葉
                          黒田エイミ
                          長瀬実夕
                          玉置成実
                          植田萌子
                          生田竜聖
                          森カンナ
                          秋元才加
                          重盛さと美
                          辻井伸行
                          佐藤ありさ
                          大島優子
                          菜々緒
                          菊田大輔
                          亀井絵里
                          多部未華子
                          鈴木勝吾
                          清水翔太
                          千葉雄大
                          佐藤健
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
                    前田健太
                    小塚崇彦
                    狩野舞子
                    斎藤佑樹
                    渡部暁斗
                    遠藤康
                    遠藤康
                    浅見八瑠奈
                    秋山翔吾
                    熊倉紫野
                    阿部香菜
                    上田春佳
                    森本貴幸
                    伊藤竜馬
                    井道千尋
                    若林舞衣子
                    浅田舞
                    國母和宏
    )
    baseurl_googlenews = "https://news.google.com/news/feeds?hl=ja&ned=us&ie=UTF-8&oe=UTF-8&output=rss&q="

    result_parse = {}
    article_url = ''
    persons = []

    persons.concat persons_entertainers
    persons.concat persons_athletes

    news_array_raw = Rails.cache.read("all_articles", expires_in: 3.hour) || []
      if news_array_raw.blank?
        persons.each do |name|
          feedUrl = baseurl_googlenews + name
          feedUrl = URI.escape(feedUrl)
          feed = Feedjira::Feed.fetch_and_parse(feedUrl)
          entry = feed.entries.first
          unless entry.blank?
            url_raw = entry.url
            article_url = url_raw.match(/url=.*$/).to_s
            article_url.slice!(0,4)
            news_array_raw << {
              title: entry.title,
              article_url: article_url,
              date: entry.published,
              name: name
            }
        end
      end
      Rails.cache.write("all_articles", news_array_raw, expires_in: 1.hour)
    end

    count_array = news_array_raw.sort{|a,b| b[:date] <=> a[:date]}.slice(start,count) || []

    if count_array.blank?
      result_parse = {
        result: true,
        status: 500,
        body: "Internal Error has occurred"
      }
    else
      result_parse = {
        result: true,
        status: 200,
        body: count_array
      }
    end

    result_parse

  end

end
