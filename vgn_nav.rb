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

def find_next_transports(id)
  uri = URI("https://start.vag.de/dm/api/v1/abfahrten/vgn/#{id}")
  result = JSON.parse(Net::HTTP.get(uri))
  result['Abfahrten'].map do |trip|
    {
      time: Time.parse(trip['AbfahrtszeitIst']).strftime("%H:%M"),
      destination: trip['Richtungstext'],
      line: trip['Linienname'],
      transport: trip['Produkt']
    }
  end
end

@options = {}

OptionParser.new do |opts|
  opts.on("-f",  "--find STOP", "Find the next transport in given stop") do |input|
    puts find_stop(input)
    puts 'Type the id of the stop'
    id = gets.chomp
    puts 'These are the next transports at this stop: '
    puts find_next_transports(id)
  end
end.parse!
