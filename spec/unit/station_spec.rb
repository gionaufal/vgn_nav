require 'vgn_nav/commands/station'

RSpec.describe VgnNav::Commands::Station do
  it "executes `station` command successfully" do
    output = StringIO.new
    options = {}
    command = VgnNav::Commands::Station.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
