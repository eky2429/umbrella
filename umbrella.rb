require "http"
require "json"


ENV.fetch("GMAPS_KEY")
ENV.fetch("PIRATE_WEATHER_KEY")

puts "========================================"
puts "Will you need an umbrella today?"
puts "========================================"
puts ""

puts "Where are you?"
#input = gets.chomp
input = "Chicago"
puts "Checking weather at #{input}..."

puts GMAPS_KEY
puts PIRATE_WEATHER_KEY

#url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + input + "&key=" + GMAPS_KEY
#google_maps_info = JSON.parse(HTTP.get(url)).fetch("results").fetch("currently").at(0).fetch("geometry").fetch("location")
#latitude = google_maps_info.fetch("lat")
#puts latitude
#longitude = google_maps_info.fetch("lng")
#puts longitude
#pp google_maps_info

#pirate_weather_info = JSON.parse(HTTP.get("https://api.pirateweather.net/forecast/#{PIRATE_WEATHER_KEY}/41.8887,-87.6355"))
