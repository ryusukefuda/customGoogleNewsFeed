require 'uri'

class Feed

  def parse


    persons = %w(田中将大 黒木メイサ 亀山耕平 新垣 結衣)
    baseurl_googlenews = "https://news.google.com/news/feeds?hl=ja&ned=us&ie=UTF-8&oe=UTF-8&output=rss&q="

    news_array_raw = []
    result_parse = {}

    persons.each {|name|
      feedUrl = baseurl_googlenews + name
      feedUrl = URI.escape(feedUrl)
      feed = Feedjira::Feed.fetch_and_parse(feedUrl)

      entry = feed.entries.first
      news_array_raw << {
          'title' => entry.title,
          'article_url' => entry.url,
          'date' => entry.published
      }
    }

    result_parse = {
      'result' => true,
      'status' => 200,
    }
    result_parse['body'] = news_array_raw

    Rails.logger.debug(result_parse)
    result_parse
  end

end
