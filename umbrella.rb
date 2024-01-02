require "http"
require "json"


ENV.fetch("GMAPS_KEY")
ENV.fetch("PIRATE_WEATHER_KEY")

puts "========================================"
puts "Will you need an umbrella today?"
puts "========================================"
puts ""

puts "Where are you?"
input = gets.chomp
puts "Checking weather at #{input}..."
