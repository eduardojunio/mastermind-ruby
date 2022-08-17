require "./src/board"
require "./src/code"

describe Board do
  let(:secret) { Code.from_text("dfab") }
  let(:board) { described_class.new(secret) }

  describe "#make_guess" do
    context "when making the first guess" do
      before do
        board.make_guess(Code.from_text("abcd"))
      end

      it "works" do
        expected_rows = [
          [Code.from_text("abcd"), [1, 1, 1, 0]]
        ]
        expect(board.rows).to eq(expected_rows)
      end

      context "when making a second guess" do
        before do
          board.make_guess(Code.from_text("dfac"))
        end

        it "works" do
          expected_rows = [
            [Code.from_text("dfac"), [2, 2, 2, 0]],
            [Code.from_text("abcd"), [1, 1, 1, 0]]
          ]
          expect(board.rows).to eq(expected_rows)
        end
      end
    end
  end

  describe "#game_ended?" do
    context "when game ended by making a correct guess" do
      before do
        board.make_guess(Code.from_text("dfab"))
      end

      it "returns true" do
        expect(board.game_ended?).to eq(true)
      end
    end

    context "when game ended by reaching the maximum amount of guesses" do
      before do
        10.times do
          board.make_guess(Code.from_text("abcd"))
        end
      end

      it "returns true" do
        expect(board.game_ended?).to eq(true)
      end
    end

    context "when game has not ended" do
      before do
        board.make_guess(Code.from_text("abcd"))
      end

      it "returns true" do
        expect(board.game_ended?).to eq(false)
      end
    end
  end
end
