require "ascii_charts"
require_relative "location_service"
require_relative "weather_service"

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

puts "========================================"
puts "    Will you need an umbrella today?"
puts "========================================"
puts "Where are you?"

location = nil

# querying for location
loop do
    users_location = gets.chomp

    begin
        puts "Let's see what the weather in #{users_location.capitalize}...."
        # TODO: handle ZeroResultsError
        location = LocationService.new(users_location).call
        puts location.to_s

        break
    rescue ArgumentError => e
        puts "Invalid argument: #{e.message}"
    rescue StandardError => e
        puts "Oops! #{e.message}"
    end
end


# querying for weather
weather = WeatherService.new(location.lat, location.lng).call
puts "The current temperature is #{weather.temperature}"
puts "Next hour: #{weather.hourly_summary}"
# puts weather.pirate_weather_url
weather.time
puts AsciiCharts::Cartesian.new(weather.hourly_precipitation(12), :bar => true, :hide_zero => true).draw
if weather.will_it_rain?(12)
    puts "You probably need an umbrella."
else 
    puts "You probably won't need an umbrella."
end

# binding.irb
