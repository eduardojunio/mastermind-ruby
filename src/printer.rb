class Printer
  def initialize(board)
    @board = board
  end

  def print_text(text)
    print text
    $stdout.flush
    text
  end

  def print_intro
    intro = <<~TEXT
      --------------------------------------
      Mastermind, written by Eduardo in Ruby
                      v1.0.0                
      --------------------------------------
    TEXT
    print_text intro
  end

  def print_space
    print_text "\n"
  end

  def print_game(with_secret: false)
    result = ""
    result += print_intro
    result += print_space
    result += print_secret if with_secret
    result += print_board
    result += print_space
    result += print_options
    result
  end

  def print_secret
    print_text board.secret.to_s + "\n"
  end

  def print_options
    print_text "A B C D\nE F G H\n"
  end

  def print_board
    empty_rows_count = max_rows - board.rows.length
    empty_rows = (0...empty_rows_count).map { empty_row }.join("\n")
    empty_rows += "\n" if empty_rows_count > 0
    board_rows = board.rows.map { |r| printable_row(r) }.join("\n")
    board_rows += "\n" if board.rows.length > 0
    print_text empty_rows + board_rows
  end

  def print_guess_prompt
    print_text "Enter your guess: "
  end

  def print_name_prompt
    print_text "Enter your name: "
  end

  private

  def board
    @board
  end

  def empty_row
    "* * * * (* * * *)"
  end

  def max_rows
    10
  end

  def printable_row(row)
    "#{row.first} (#{self.printable_hint(row.last)})"
  end

  def printable_hint(hint)
    hint.map do |e|
      case e
      when 0
        "*"
      when 1
        "W"
      when 2
        "R"
      end
    end.join(" ")
  end
end
