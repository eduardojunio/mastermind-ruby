require("forwardable")

require("./src/board")
require("./src/code")
require("./src/player")
require("./src/printer")
require("./src/keyboard_input")
require("./src/ai_input")

class Game
  extend Forwardable

  def_delegators :printer, :print_intro, :print_space, :print_game, :print_text, :print_name_prompt, :print_guess_prompt

  def initialize
    @keyboard_input = KeyboardInput.new
    computer = Player.new("Computer", AIInput.new)
    secret = Code.from_text(computer.get_code)
    @board = Board.new(secret)
    @printer = Printer.new(board)
  end

  def game_loop
    clear_screen
    print_intro
    print_space
    @player = Player.new(get_player_name, keyboard_input)
    until board.game_ended?
      begin
        clear_screen
        print_game
        print_space
        guess = get_guess
      rescue => exception
        print_text "#{exception}!"
        keyboard_input.get
        retry
      end
      board.make_guess(guess)
    end
    clear_screen
    print_game(with_secret: true)
    print_space
    if board.any_right_guess?
      print_text "Congratulations #{player.name.upcase}, you won!!!!!!!!"
    else
      print_text "You lost! Try again..."
    end
    print_space
  end

  private

  def keyboard_input
    @keyboard_input
  end

  def board
    @board
  end

  def player
    @player
  end

  def printer
    @printer
  end

  def get_player_name
    print_name_prompt
    keyboard_input.get
  end

  def get_guess
    print_guess_prompt
    Code.from_text(player.get_code)
  end

  def clear_screen
    system("clear")
  end
end
