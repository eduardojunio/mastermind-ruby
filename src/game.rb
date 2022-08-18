require("./src/board")
require("./src/code")
require("./src/player")
require("./src/printer")
require("./src/keyboard_input")
require("./src/ai_input")

class Game
  def initialize
    @keyboard_input = KeyboardInput.new
  end

  def loop
    system("clear")
    show_intro
    print_space
    player = Player.new(get_player_name, keyboard_input)
    computer = Player.new("Computer", AIInput.new)
    secret = Code.from_text(computer.get_code)
    board = Board.new(secret)
    until board.game_ended?
      begin
        system("clear")
        show_intro
        print_space
        Printer.print_board(board)
        print_space
        Printer.print_options
        print_space
        Printer.print_guess_prompt
        guess = Code.from_text(player.get_code)
      rescue => exception
        Printer.show("#{exception}!")
        keyboard_input.get
        retry
      end
      board.make_guess(guess)
    end
    system("clear")
    if board.any_right_guess?
      show_intro
      print_space
      Printer.print_secret(board)
      Printer.print_board(board)
      print_space
      player_won = <<~SHOW
        Congratulations #{player.name.upcase}, you won!!!!!!!!
      SHOW
      Printer.show player_won
      print_space
    else
      show_intro
      print_space
      Printer.print_secret(board)
      Printer.print_board(board)
      print_space
      player_lost = <<~SHOW
        You lost! Try again...
      SHOW
      Printer.show player_lost
      print_space
    end
  end

  private

  def keyboard_input
    @keyboard_input
  end

  def show_intro
    intro = <<~SHOW
      --------------------------------------
      Mastermind, written by Eduardo in Ruby
                      v1.0.0                
      --------------------------------------
    SHOW
    Printer.show(intro)
  end

  def get_player_name
    Printer.print_name_prompt
    keyboard_input.get
  end

  def print_space
    Printer.show "\n"
  end
end
