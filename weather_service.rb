require "http"
require "dotenv/load"
require "json"

class WeatherService


  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end

  def call
    raw = HTTP.get(pirate_weather_url)
    @response = JSON.parse(raw)

    self
  end

  def temperature
    @response.dig("currently","temperature")
  end

  def hourly_summary
    @response.dig("hourly","summary")
  end 


  private

  def pirate_weather_api_key
    ENV.fetch("PIRATE_WEATHER_KEY")
  end  

  def pirate_weather_url
    "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/#{@lat},#{@lng}"
  end
end