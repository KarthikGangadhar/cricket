require 'typhoeus'
require './lib/cricket_api/request.rb'

module CricApi
  class ProfessionalProfile
    def initialize
      
    end

    

    def getResponseforHome                        
      api_requests = {
        :news => Typhoeus::Request.new("https://apecricket.herokuapp.com/api/news",
                                method: :get,
                                headers: { 'ContentType' => "application/json/"}),
        :matchcalendar => Typhoeus::Request.new("https://apecricket.herokuapp.com/api/matchCalendar",
                                method: :get,
                                headers: { 'ContentType' => "application/json"}),
        :cricket => Typhoeus::Request.new("https://apecricket.herokuapp.com/api/cricket",
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
    
def getResponseforBallbyBall(unique_id)                        
      api_requests = {
        :ballbyball => Typhoeus::Request.new("http://apecricket.herokuapp.com/api/ballByBall",
                                method: :post,
                                headers: { 'ContentType' => "application/json/"},
                                body: {unique_id: unique_id.to_s } ),
        :cricketScore => Typhoeus::Request.new("http://apecricket.herokuapp.com/api/cricketScore",
                                method: :post,
                                headers: { 'ContentType' => "application/json"},
                                body: {unique_id: unique_id.to_s } )
      }
      
      hydra = Typhoeus::Hydra.new(max_concurrency: api_requests.count) 
      
      requests = [:ballbyball,:cricketScore].each_with_object({}) do |type,hash_obj|
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
    
    
    
  end
end
