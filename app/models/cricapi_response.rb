require 'typhoeus'
require './lib/cricket_api/request.rb'

module CricApi
  class ProfessionalProfile
    def initialize
      # response = getResponse
      # # binding.pry
      # cricket = {:response => response }
      # binding.pry
    end

    # def getrequest
      # api_requests = {
        # :news => cricApires.matchCalendar,
        # :matchcalendar => cricApires.getNews
      # }
    # end

    def getResponse 
      # binding.pry                       
      api_requests = {
        :news => Typhoeus::Request.new("https://cricketlive.herokuapp.com/api/news",
                                method: :get,
                                headers: { 'ContentType' => "application/json/"}),
        :matchcalendar => Typhoeus::Request.new("https://cricketlive.herokuapp.com/api/matchCalendar",
                                method: :get,
                                headers: { 'ContentType' => "application/json"}),
        :cricket => Typhoeus::Request.new("https://cricketlive.herokuapp.com/api/cricket",
                                method: :get,
                                headers: { 'ContentType' => "application/json"})
      }
      
      hydra = Typhoeus::Hydra.new(max_concurrency: api_requests.count) 
      
      requests = [:news,:matchcalendar,:cricket].each_with_object({}) do |type,hash_obj|
        hash_obj[type] = api_requests[type]
        hydra.queue(hash_obj[type])
      end
      
      hydra.run
      teamObj = {}
      
      responses = requests.each_with_object({}) do | (name, req) |
        teamObj[name] = JSON.parse(req.response.body)
      end
    
      return teamObj 
      
      
    end
    
    
    # @@cricapi_calls = {
      # :for_sale => GetNewsEndPointRequest,
      # :recently_sold => GetScheduleEndPointRequest,
    # }
#     
    # def GetNewsEndPointRequest
      # Typhoeus::Request.new("https://cricketlive.herokuapp.com/api/news",
                                # method: :get,
                                # headers: { 'ContentType' => "application/json/"})
    # end
#     
    # def GetScheduleEndPointRequest
      # Typhoeus::Request.new("https://cricketlive.herokuapp.com/api/matchCalendar",
                                # method: :get,
                                # headers: { 'ContentType' => "application/json"})
    # end
    
  end
end
