require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class PlayerstatController < ApplicationController
  def show
    cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)  
   # @playerStats = cricApires.jsonRead('./lib/cricket_api/json_data/playerStat.json')
    @playerStats = cricApires.playerStats(params[:pid]);
  end
end