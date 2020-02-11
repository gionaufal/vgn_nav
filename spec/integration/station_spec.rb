RSpec.describe "`vgn_nav station` command", type: :cli do
  it "executes `vgn_nav help station` command successfully" do
    output = `vgn_nav help station`
    expected_output = <<-OUT
Usage:
  vgn_nav station

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
