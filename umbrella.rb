require "http"
require "dotenv/load"
require "json"

# TODO: 
# Add text: Will you need an umbrella today?
# Add question: Where are you?
# Get user input
# Add text: Let's see what the weather in parsed_user_input
# Fetch location info using Google maps
# Print latitude and longitude
# Fetch the weaher info for parsed_user_input's location
# Print the temperature
# Print the next hour summary
# Print precipitation chart
# Display recommendation


pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887,-87.6355"

raw_response = HTTP.get(pirate_weather_url)
parsed_response = JSON.parse(raw_response)
parsed_response.dig("currently","temperature")

binding.irb