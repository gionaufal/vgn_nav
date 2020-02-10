require 'optparse'
require 'net/http'
require 'json'
require 'time'

def find_stop(input)
  uri = URI("https://start.vag.de/dm/api/v1/haltestellen/vgn?name=#{input}")
  result = JSON.parse(Net::HTTP.get(uri))
  result['Haltestellen'].map do |stop|
    {
      name: stop['Haltestellenname'],
      id: stop['VGNKennung'],
      transports: stop['Produkte']
    }
  end
end

def format_stops(stops)
  stops.map.with_index do |stop, index|
    "[#{index}] - #{stop[:name]} with #{stop[:transports]} "
  end
end

def find_next_transports(id)
  uri = URI("https://start.vag.de/dm/api/v1/abfahrten/vgn/#{id}")
  result = JSON.parse(Net::HTTP.get(uri))
  result['Abfahrten'].map do |trip|
    scheduled = Time.parse(trip['AbfahrtszeitIst'])
    time_to_scheduled = (scheduled - Time.now) / 60

    "In #{time_to_scheduled.to_i} minutes, #{trip['Produkt']} line #{trip['Linienname']} to #{trip['Richtungstext']} at #{scheduled.strftime('%H:%M')}"
  end
end

@options = {}

OptionParser.new do |opts|
  opts.on("-f",  "--find STOP", "Find the next transport in given stop") do |input|
    stops = find_stop(input)
    puts format_stops(stops)
    puts 'Chose the desired stop'
    id = gets.chomp.to_i
    puts 'These are the next transports at this stop: '
    puts find_next_transports(stops[id][:id])
  end
end.parse!
