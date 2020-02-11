# frozen_string_literal: true

require 'thor'

module VgnNav
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'vgn_nav version'
    def version
      require_relative 'version'
      puts "v#{VgnNav::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'station', 'Searches for a station and shows next departures in it'
    method_option :station, aliases: '-s', type: :string,
                         desc: 'Searches directly for the given station'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def station(*)
      if options[:help]
        invoke :help, ['station']
      else
        require_relative 'commands/station'
        VgnNav::Commands::Station.new(options).execute
      end
    end
  end
end
