require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class PlayerstatController < ApplicationController
  def show
    cricApires = CricApi::Request.new('https://cricketlive.herokuapp.com', 0)
    isOffline = true
    
    @playerStats = cricApires.jsonRead('./lib/cricket_api/json_data/playerStat.json')
  end
end