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

  def hourly
    # {"summary": String, "icon": String, "data": Array}
    @response.fetch("hourly")
  end

  def hourly_summary
    hourly.fetch("summary")
  end 

  def hourly_data
    hourly.fetch("data")
  end

  def time
    next_hour_data = hourly_data[1..12]

    next_hour_data.each do |hour_hash|
      hour = hour_hash.fetch("time")
      precip_probability = hour_hash.fetch("precipProbability")
      next_hour = ((Time.at(hour) - Time.now) / 60 /60).round + 1
      puts "In #{next_hour} hours, there is a #{(precip_probability * 100).to_i}% chance of precipitation."
    end
  end

  # [ [hour, precipitation_probability] ]
  def hourly_precipitation(num_hours = 48)
    precip_probability_array = []

    hourly_data.first(num_hours).each_with_index do |hour_hash, index|
      precip_probability = hour_hash.fetch("precipProbability")
      precip_probability_integer = (precip_probability * 100).to_i
      precip_probability_array.push([index, precip_probability_integer])
    end

    return precip_probability_array
  end

  def will_it_rain?(num_hours = 48)
    # if the precip_probability > 0.10
    # [0, 1, 2].any? {|element| element > 1 } # => true
    result = hourly_precipitation.first(num_hours).any? {|precip_probability| precip_probability.at(1) > 10 }

    return result
  end

  private

  def pirate_weather_api_key
    ENV.fetch("PIRATE_WEATHER_KEY")
  end  

  def pirate_weather_url
    "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/#{@lat},#{@lng}"
  end
end
