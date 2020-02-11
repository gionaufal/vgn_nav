require 'net/http'
require 'json'

module VgnNav
  class Http
    class << self
      def get(endpoint, input)
        uri = URI("https://start.vag.de/dm/api/v1/#{endpoint}/vgn#{input}")
        JSON.parse(Net::HTTP.get(uri))
      end
    end
  end
end
