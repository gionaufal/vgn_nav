require 'spec_helper'
require 'vgn_nav/commands/station'

RSpec.describe VgnNav::Commands::Station do
  it "executes `station` command successfully" do
    output = StringIO.new
    options = {station: 'maxfeldstr.'}
    command = VgnNav::Commands::Station.new(options)

    command.execute(output: output)

    expect(output.string).to match(/These are the next departures at this station/)
    expect(output.string).to match(/Bus line/)
  end
end
