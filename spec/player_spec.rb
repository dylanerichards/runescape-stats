require_relative "../lib/player"
require_relative "spec_helper"

describe Player do
  describe "#initialize" do
    brink = Player.new(username: "Brink")

    it "sets the username to the supplied username" do
      expect(brink.username).to eq "brink"
    end
  end
end
