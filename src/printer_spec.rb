require("./src/printer")
require("./src/board")
require("./src/code")

describe Printer do
  let(:secret) { Code.from_text("hgfd") }
  let(:board) { Board.new(secret) }
  let(:printer) { Printer.new(board) }

  describe "#print_text" do
    it "works" do
      expect(printer.print_text("hello")).to eq("hello")
    end
  end

  describe "#print_intro" do
    it "prints game name" do
      expect(printer.print_intro).to match("Mastermind")
    end

    it "prints author name" do
      expect(printer.print_intro).to match("Eduardo")
    end

    it "prints version" do
      expect(printer.print_intro).to match("v1.0.0")
    end
  end

  describe "#print_space" do
    it "works" do
      expect(printer.print_space).to eq("\n")
    end
  end

  describe "#print_game" do
    it "prints empty rows" do
      expect(printer.print_game).to match(/\* \* \* \* \(\* \* \* \*\)/)
    end

    it "does not print the secret" do
      expect(printer.print_game).not_to match("H G F D")
    end

    context "when passing the with_secret option" do
      it "prints the secret" do
        expect(printer.print_game(with_secret: true)).to match("H G F D")
      end
    end
  end

  describe "#print_secret" do
    it "works" do
      expect(printer.print_secret).to eq("H G F D\n")
    end
  end

  describe "#print_options" do
    it "works" do
      expect(printer.print_options).to eq("A B C D\nE F G H\n")
    end
  end

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
        expect(printer.print_board).to eq(expected_result)
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
        expect(printer.print_board).to eq(expected_result)
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
        expect(printer.print_board).to eq(expected_result)
      end
    end
  end

  describe "#print_guess_prompt" do
    it "works" do
      expect(printer.print_guess_prompt).to eq("Enter your guess: ")
    end
  end

  describe "#print_name_prompt" do
    it "works" do
      expect(printer.print_name_prompt).to eq("Enter your name: ")
    end
  end
end
