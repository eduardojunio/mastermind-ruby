require("./src/player")
require("./src/ai_input")

describe Player do
  let(:input_method) { AIInput.new }
  let(:player) { described_class.new("Jockssany", input_method) }

  describe "#name" do
    it "works" do
      expect(player.name).to eq("Jockssany")
    end
  end

  describe "#get_code" do
    it "works" do
      expect(player.get_code.class.name).to eq("String")
    end
  end
end
