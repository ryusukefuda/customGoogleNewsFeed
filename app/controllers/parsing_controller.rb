

class ParsingController < ApplicationController

  def index

    feed = Feed.new
    @news_json = feed.parse.to_json

  end
end
