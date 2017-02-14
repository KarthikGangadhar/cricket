require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class BallbyballController < ApplicationController
   def show
    unique_id =  params[:unique_id]
    cricApires = CricApi::Request.new('https://cricketlive.herokuapp.com', 0)
    isOffline = false
    if !isOffline
      # @cricket = cricApires.cricket
      # @matchCalendar = cricApires.matchCalendar
      # @playerStats = cricApires.playerStats(35320)
      # @commentry = cricApires.commentry(1034821)
      # @news = cricApires.getNews
      request = CricApi::ProfessionalProfile.new().getResponseforBallbyBall(unique_id)
      # binding.pry
      @ballbyball = request[:ballbyball]
      @cricketScore = request[:cricketScore]
      # @match_ids = cricApires.match_ids
      # @match_response = cricApires.match_response(@match_ids)
    else
      # @cricket = cricApires.jsonRead('./lib/cricket_api/json_data/cricket.json')
      # @matchCalendar = cricApires.jsonRead('./lib/cricket_api/json_data/schedule.json')
      # @playerStats = cricApires.jsonRead('./lib/cricket_api/json_data/playerStat.json')
      # @commentry = cricApires.jsonRead('./lib/cricket_api/json_data/commentary.json')
      # @news = cricApires.jsonRead('./lib/cricket_api/json_data/news.json')
      # @ballbyball = cricApires.jsonRead('./lib/cricket_api/json_data/ballbyball.json')
      # @match_ids = cricApires.match_ids
      # binding.pry
      # @match_response = cricApires.match_response(@match_ids)
      # parameter_file = File.new('liveupdate.txt', "w")
      # parameter_file.puts(@match_response)
      # binding.pry
      # @scores = cricApires.jsonRead('./lib/cricket_api/json_data/scores.json')
    end

  end

end
