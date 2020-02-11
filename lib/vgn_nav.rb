# frozen_string_literal: true

require 'vgn_nav/version'

module VgnNav
  class Error < StandardError; end

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

    def next_departures(id)
      uri = URI("https://start.vag.de/dm/api/v1/abfahrten/vgn/#{id}")
      result = JSON.parse(Net::HTTP.get(uri))
      result['Abfahrten'].map do |trip|
        scheduled = Time.parse(trip['AbfahrtszeitIst'])
        time_to_scheduled = ((scheduled - Time.now) / 60).to_i

        "In #{time_to_scheduled} #{plural('minute', time_to_scheduled)}, " \
          "#{trip['Produkt']} line #{trip['Linienname']} " \
          "to #{trip['Richtungstext']} at #{scheduled.strftime('%H:%M')}"
      end
    end

    private

    def plural(string, count)
      return string if count == 1 || count.negative?

      string + 's'
    end
  end
end
