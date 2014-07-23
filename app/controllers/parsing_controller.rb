

class ParsingController < ApplicationController

  def index

    feed = Feed.new

    start = params[:start].to_i
    count = params[:count].to_i == 0 ? 10 : params[:count].to_i

    @news_json = feed.parse(start, count).to_json

  end

end
