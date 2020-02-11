require 'net/http'
require 'json'
require 'time'

class Transports
  class << self
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
  end
end
