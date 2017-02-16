require './lib/cricket_api/request.rb'

class NewsController < ApplicationController
  def show      
      cricApires = CricApi::Request.new('https://cricketlive.herokuapp.com', 0)
      @news = cricApires.getNews
  end
end

