require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class CricketController < ApplicationController
  def show      
      request = CricApi::ProfessionalProfile.new().getResponseforHome
      binding.pry
      @news = {
        :news => request[:news],
        :count => request[:news]['data']['data'].count
      }
      @matchCalendar = request[:matchcalendar]
      @cricket = request[:cricket]
  end
end
