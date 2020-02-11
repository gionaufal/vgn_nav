require 'optparse'
require 'time'
require './src/stations.rb'
require './src/transports.rb'

def plural(string, count)
  return string if count == 1 || count < 0
  string + 's'
end

OptionParser.new do |opts|
  opts.on("-f",  "--find STATION", "Find the next transports in given station") do |input|
    stations = Stations.find_station(input)
    puts Stations.format_stations(stations)
    puts 'Chose the desired station'
    id = gets.chomp.to_i
    puts 'These are the next transports at this station: '
    puts Transports.find_next_transports(stations[id][:id])
  end
end.parse!
