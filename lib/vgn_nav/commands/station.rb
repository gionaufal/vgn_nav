# frozen_string_literal: true

require_relative '../command'
require_relative '../../vgn_nav.rb'
require 'net/http'
require 'json'
require 'time'
require 'pry-byebug'

module VgnNav
  module Commands
    class Station < VgnNav::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        name = @options[:station]
        name = prompt.ask('Type the name of the station: ') if name.nil?

        stations = VgnNav.find_station(name)

        id = 0 if stations.size == 1
        id = prompt.select('Select the station', VgnNav.format_stations(stations)).split(' ').first.to_i unless id

        output.puts 'These are the next transports at this station: '
        output.puts VgnNav.next_departures(stations[id][:id])
      end
    end
  end
end
