require_relative "../lib/player"
require_relative "spec_helper"

describe Player do
  describe "#initialize" do
    survive = Player.new(username: "Survive")

    it "sets the username to the supplied username" do
      expect(survive.username).to eq "survive"
    end
  end
end
