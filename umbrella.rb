require "http"
require "json"
require "ascii_charts"


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
mayRain = false

index = 0
points = []
hourly_data.each{ |hash|
  if index > 12
    break
  end
  chanceofPrecip = (hash["precipProbability"] * 100).round

  if chanceofPrecip >= 10 && mayRain == false
    mayRain = true
  end

  points[index] = [index,chanceofPrecip]
  puts "In #{index} hours, there is a #{chanceofPrecip}% chance of precipitation."
  index += 1
}
puts AsciiCharts::Cartesian.new(points, :bar => true, :hide_zero => true).draw

if mayRain == true
  puts "You might want to take an umbrella!"
else
  puts "You probably won't need an umbrella."
end
