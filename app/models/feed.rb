require 'uri'

class Feed

  def parse

    persons = %w(田中将大 黒木メイサ 亀山耕平 新垣結衣)
    baseurl_googlenews = "https://news.google.com/news/feeds?hl=ja&ned=us&ie=UTF-8&oe=UTF-8&output=rss&q="

    news_array_raw = []
    result_parse = {}
    article_url = ''

    persons.each do|name|
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

    result_parse = {
      'result' => true,
      'status' => 200,
    }
    result_parse['body'] = news_array_raw
    result_parse
  end

end
