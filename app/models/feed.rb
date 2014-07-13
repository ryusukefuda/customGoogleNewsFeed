require 'uri'

class Feed

  def parse

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
    baseurl_googlenews = "https://news.google.com/news/feeds?hl=ja&ned=us&ie=UTF-8&oe=UTF-8&output=rss&q="

    news_array_raw = []
    result_parse = {}
    article_url = ''
    persons = []

    persons.concat persons_entertainers
    persons.concat persons_athletes

    persons.each do |name|
      feedUrl = baseurl_googlenews + name
      feedUrl = URI.escape(feedUrl)
      feed = Feedjira::Feed.fetch_and_parse(feedUrl)

      entry = feed.entries.first
      url_raw = entry.url
      article_url = url_raw.match(/url=.*$/).to_s
      article_url.slice!(0,4)

      news_array_raw << {
          title: entry.title,
          article_url: article_url,
          date: entry.published
      }
    end

    if news_array_raw.blank?
      result_parse = {
        result: true,
        status: 500,
        body: "Internal Error has occurred"
      }
    else
      result_parse = {
        result: true,
        status: 200,
        body: news_array_raw
      }

    end
    result_parse

  end

end
