require "http"
require "dotenv/load"
require "json"

class LocationService
  attr_reader :lat, :lng, :place_name

  def initialize(place_name)
    @place_name = place_name
  end

  def call
    raw = HTTP.get(gmaps_url)
    response = JSON.parse(raw)

    results = response.fetch("results")
    location = results.first.dig("geometry", "location")
    
    @lat = location["lat"]
    @lng = location["lng"]

    self
  end

  def to_s
    "Your coordinates are #{@lat}, #{@lng}."
  end

  private

  def gmaps_api_key
    ENV.fetch("GMAPS_KEY")
  end

  def gmaps_url
    # TODO: query string params from hash
    # {
    #     address: users_location.gsub(" ", "%20"),
    #     key: gmaps_api_key
    # }
    "https://maps.googleapis.com/maps/api/geocode/json?address=#{@place_name.gsub(" ", "%20")}&key=#{gmaps_api_key}"
  end
end