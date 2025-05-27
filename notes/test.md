```ruby
require "minitest/autorun"
require "active_support/all"
require_relative "../location_service"

class TestLocationService < Minitest::Test
  def setup
    @place_name = "Chicago"
    @expected_lat = 41.8781
    @expected_lng = -87.6298
  end

  def test_call_returns_correct_coordinates
    location = LocationService.new(@place_name).call

    assert_in_delta @expected_lat, location.lat, 0.1
    assert_in_delta @expected_lng, location.lng, 0.1
  end
end
```