require("./src/printer")
require("./src/board")
require("./src/code")

describe Printer do
  let(:secret) { Code.from_text("hgfd") }
  let(:board) { Board.new(secret) }

  describe "#print_board" do
    context "when board has only one move" do
      before do
        board.make_guess(Code.from_text("abcd"))
      end

      it "prints correctly" do
        expected_result = <<~BOARD
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          A B C D (R * * *)
        BOARD
        expect(described_class.print_board(board)).to eq(expected_result)
      end
    end

    context "when board is full" do
      before do
        board.make_guess(Code.from_text("abcd"))
        8.times do
          board.make_guess(Code.from_text("cdef"))
        end
        board.make_guess(Code.from_text("efgh"))
      end

      it "prints correctly" do
        expected_result = <<~BOARD
          E F G H (W W W *)
          C D E F (W W * *)
          C D E F (W W * *)
          C D E F (W W * *)
          C D E F (W W * *)
          C D E F (W W * *)
          C D E F (W W * *)
          C D E F (W W * *)
          C D E F (W W * *)
          A B C D (R * * *)
        BOARD
        expect(described_class.print_board(board)).to eq(expected_result)
      end
    end

    context "when board is empty" do
      it "prints correctly" do
        expected_result = <<~BOARD
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
          * * * * (* * * *)
        BOARD
        expect(described_class.print_board(board)).to eq(expected_result)
      end
    end
  end

  describe "#print_guess_prompt" do
    it "works" do
      expect(described_class.print_guess_prompt).to eq("Enter your guess: ")
    end
  end

  describe "#print_name_prompt" do
    it "works" do
      expect(described_class.print_name_prompt).to eq("Enter your name: ")
    end
  end

  describe "#print_secret" do
    it "works" do
      expect(described_class.print_secret(board)).to eq("H G F D\n")
    end
  end

  describe "#print_options" do
    it "works" do
      expect(described_class.print_options).to eq("A B C D\nE F G H\n")
    end
  end
end
