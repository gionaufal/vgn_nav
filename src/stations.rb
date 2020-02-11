require 'net/http'
require 'json'

class Stations
  class << self
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
  end
end
