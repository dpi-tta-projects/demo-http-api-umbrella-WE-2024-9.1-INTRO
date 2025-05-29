require "http"
require "dotenv/load"
require "json"

class LocationService
  attr_reader :lat, :lng, :place_name

  API_STATUSES = {
    ok: "OK",
    zero_results: "ZERO_RESULTS"
  }

  def initialize(place_name)
    @place_name = place_name
  end

  def call
    raw = HTTP.get(gmaps_url)
    response = JSON.parse(raw)

    results = response.fetch("results")
    status = response.fetch("status")

    if status == API_STATUSES[:zero_results]
      raise ArgumentError, "Location for '#{place_name}' is not found. Try again:"
    end

    result = results.first

    # TODO: rescue KeyError: key not found
    geometry = result.fetch("geometry")

    # TODO: rescue KeyError: key not found
    location = geometry.fetch("location")
    
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