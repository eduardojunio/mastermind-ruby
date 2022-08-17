class Printer
  def self.show(text)
    print text
    STDOUT.flush
    text
  end

  def self.print_board(board)
    empty_rows_count = self.rows - board.rows.length
    empty_rows = (0...empty_rows_count).map { self.empty_row }.join("\n")
    empty_rows += "\n" if empty_rows_count > 0
    board_rows = board.rows.map { |r| self.printable_row(r) }.join("\n")
    board_rows += "\n" if board.rows.length > 0
    self.show empty_rows + board_rows
  end

  def self.print_guess_prompt
    self.show "Enter your guess: "
  end

  def self.print_name_prompt
    self.show "Enter your name: "
  end

  def self.print_secret(board)
    self.show board.secret.to_s + "\n"
  end

  def self.print_options
    self.show "A B C D\nE F G H\n"
  end

  private_class_method def self.empty_row
    "* * * * (* * * *)"
  end

  private_class_method def self.rows
    10
  end

  private_class_method def self.printable_row(row)
    "#{row.first} (#{self.printable_hint(row.last)})"
  end

  private_class_method def self.printable_hint(hint)
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
