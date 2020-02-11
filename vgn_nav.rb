require 'optparse'
require 'net/http'
require 'json'
require 'time'

def find_station(input)
  uri = URI("https://start.vag.de/dm/api/v1/haltestellen/vgn?name=#{input}")
  result = JSON.parse(Net::HTTP.get(uri))
  result['Haltestellen'].map do |station|
    {
      name: station['Haltestellenname'],
      id: station['VGNKennung'],
      transports: station['Produkte']
    }
  end
end

def format_stations(stations)
  stations.map.with_index do |station, index|
    "[#{index}] - #{station[:name]} with #{station[:transports]} "
  end
end

def plural(string, count)
  return string if count == 1 || count < 0
  string + 's'
end

def find_next_transports(id)
  uri = URI("https://start.vag.de/dm/api/v1/abfahrten/vgn/#{id}")
  result = JSON.parse(Net::HTTP.get(uri))
  result['Abfahrten'].map do |trip|
    scheduled = Time.parse(trip['AbfahrtszeitIst'])
    time_to_scheduled = ((scheduled - Time.now) / 60).to_i

    "In #{time_to_scheduled} #{plural('minute', time_to_scheduled)}, " +
      "#{trip['Produkt']} line #{trip['Linienname']} " +
      "to #{trip['Richtungstext']} at #{scheduled.strftime('%H:%M')}"
  end
end

OptionParser.new do |opts|
  opts.on("-f",  "--find STATION", "Find the next transports in given station") do |input|
    stations = find_station(input)
    puts format_stations(stations)
    puts 'Chose the desired station'
    id = gets.chomp.to_i
    puts 'These are the next transports at this station: '
    puts find_next_transports(stations[id][:id])
  end
end.parse!
