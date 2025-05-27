# Intro to APIs

Application Programming Interfaces (APIs) allow you to request web data from many external services. 

## Placing requests with Ruby

First add [gem http](https://github.com/httprb/http) to your Gemfile

```ruby
gem "http"
```

Then `require "http"` to your `.rb` file.  
Then use it: 
```ruby
puts HTTP.get("https://en.wikipedia.org/wiki/Chicago").to_s
```
- The `http.rb` gem includes a class, `HTTP`, that has a class method `get` (and `post`, `patch`, `delete`, etc, for the other verbs).
- The argument to `get()` should be a `String` containing the full URL of the resource you want to request.    
- The `get` method returns an object that represents the HTTP response.    
- The `HTTP::Response` object has a method called `body` which will return a new object `HTTP::Response::Body`
- The `HTTP::Response::Body` contents can be retrieved by calling `to_s` on it, or we can just shortcut that and call `to_s` on the response itself. Also there are `headers` and `status`.

## Pirate Weather

[merrysky.net](https://merrysky.net/forecast/merchandise%20mart/us)

```ruby
require "http"

puts HTTP.get("https://merrysky.net/forecast/merchandise%20mart/us").to_s
```

Fortunately, there’s a parallel version of that same page but in a format that is much better for programs to understand. Try visiting this URL in a browser tab:

```html
https://api.pirateweather.net/forecast/API_KEY_FROM_COURSE_SECRETS/41.8887,-87.6355
```
[secrets](https://learn.firstdraft.com/runs/76/learner/secrets)

Install `gem "dotenv"` and store the key in `.env`. To check if the key is set correctly:
```ruby
# /env_test.rb
require "dotenv/load"

pp ENV.fetch("PIRATE_WEATHER_API_KEY")
```
Then write a program:

```ruby
require "http"
require "json"
require "dotenv/load"

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_API_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887,-87.6355"

raw_response = HTTP.get(pirate_weather_url)
parsed_response = JSON.parse(raw_response)
current_temp = parsed_response.fetch("currently").fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."
```
Ruby includes a class called `JSON` that can convert a `String` containing `JSON` into Ruby `Hashes` & `Arrays`

## Google Maps Geocoding

```html
https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=API_KEY_FROM_COURSE_SECRETS
```

[ascii_charts](https://github.com/benlund/ascii_charts)

## Unix timestamp
`Unix timestamp` — it represents the number of seconds that have passed since **January 1, 1970 (UTC)**

```ruby
Time.at(1747879200) # => 2025-07-21 12:00:00 -0500
```

### 🕰️ The Origin of Unix Time
Unix time comes from the Unix operating system, which was created in the late 1960s and early 1970s at AT&T Bell Labs by engineers like Ken Thompson, Dennis Ritchie, and others.

### 🧨 Fun Fact: Year 2038 Problem
Unix time is stored in many systems as a 32-bit signed integer. That maxes out on:

**Tuesday, January 19, 2038, at 03:14:07 UTC**

After that, the number overflows and wraps around to a negative number, causing possible failures — a bit like the Y2K problem. This is called the **Year 2038 problem**, and many systems are already being updated to use 64-bit timestamps to avoid it.

## Error handeling

```ruby
    if status != "OK" || results.empty?
      raise ArgumentError, "Location for '#{place_name}' is not found. Try again:"
    end
```

`ArgumentError` is a built-in Ruby exception that is raised when a method receives arguments that are incorrect, invalid, or unexpected — either in type, number, or value.

Then wrap your code in the loop:
```ruby
location = nil

loop do
    users_location = gets.chomp

    begin
        # querying for location
        break
    rescue ArgumentError => e
        puts "#{e.message}"
    end
end
```