require "./code"

describe Code do
  describe "::from_text" do
    context "with lowercase unseparated input" do
      it "initializes correctly" do
        expect(Code.from_text("bcde").value).to eq([1, 2, 3, 4])
      end
    end

    context "with uppercase space-separated input" do
      it "initializes correctly" do
        expect(Code.from_text("E F G H").value).to eq([4, 5, 6, 7])
      end
    end

    context "with crazy but valid input" do
      it "initializes correctly" do
        expect(Code.from_text("   e    F    g   h    ").value).to eq([4, 5, 6, 7])
      end
    end
  end

  describe "#==" do
    context "when comparing equivalent codes" do
      it "returns true" do
        expect(Code.from_text("efgh") == Code.from_text("efgh")).to eq(true)
      end
    end

    context "when comparing different codes" do
      it "returns false" do
        expect(Code.from_text("efgh") == Code.from_text("abcd")).to eq(false)
      end
    end
  end

  describe "#value" do
    it "returns value" do
      expect(Code.new(0, 1, 2, 3).value).to eq([0, 1, 2, 3])
    end
  end

  describe "#get_hint" do
    context "when partially matching elements completely" do
      it "returns the correct hint" do
        code1 = Code.from_text("efgh")
        code2 = Code.from_text("abgh")
        expect(code1.get_hint(code2)).to eq([0, 0, 2, 2])
      end
    end

    context "when matching all elements completely" do
      it "returns the correct hint" do
        code1 = Code.from_text("abcd")
        code2 = Code.from_text("abcd")
        expect(code1.get_hint(code2)).to eq([2, 2, 2, 2])
      end
    end

    context "when matching all elements but in different positions" do
      it "returns the correct hint" do
        code1 = Code.from_text("abcd")
        code2 = Code.from_text("dcba")
        expect(code1.get_hint(code2)).to eq([1, 1, 1, 1])
      end
    end

    context "when not matching any elements" do
      it "returns the correct hint" do
        code1 = Code.from_text("abcd")
        code2 = Code.from_text("efgh")
        expect(code1.get_hint(code2)).to eq([0, 0, 0, 0])
      end
    end
  end
end
