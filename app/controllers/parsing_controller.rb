

class ParsingController < ApplicationController

  def index

    count = params[:count].to_i
    start = params[:start].to_i
    count_array = []

    feed = Feed.new

    count = count == 0 ? 10 : count
    count_array = feed.parse.slice(start,count)

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

    @news_json = result_parse.to_json

  end

end
