require "http"
require "json"


GMAPS_KEY = ENV.fetch("GMAPS_KEY")
PIRATE_WEATHER_KEY = ENV.fetch("PIRATE_WEATHER_KEY")

puts "========================================"
puts "Will you need an umbrella today?"
puts "========================================"
puts ""

puts "Where are you?"
input = gets.chomp

puts "Checking weather at #{input}..."
google_maps_info = JSON.parse(HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=" + input + "&key=" + GMAPS_KEY)).fetch("results").at(0).fetch("geometry").fetch("location")
latitude = google_maps_info.fetch("lat")
longitude = google_maps_info.fetch("lng")

pirate_weather_info = JSON.parse(HTTP.get("https://api.pirateweather.net/forecast/#{PIRATE_WEATHER_KEY}/#{latitude},#{longitude}"))
current_temperature = pirate_weather_info.fetch("currently").fetch("temperature")
puts "It is currently #{current_temperature}°F."

hourly_data = pirate_weather_info.fetch("hourly").fetch("data")

is_raining_next_hour = hourly_data[1]["precipType"] == "rain"
if is_raining_next_hour == false
  puts "Next hour: Clear"
  puts "You probably won't need an umbrella."
else
  puts "Next hour: Rainy"
  index = 0
  hourly_data.each{ |hash|
  puts "In #{index} hours, there is a #{hash["precipProbability"]}% chance of precipitation."
  index += 1
  puts "You might want to take an umbrella!"
}
end
