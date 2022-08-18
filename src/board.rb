class Board
  attr_reader :rows, :secret

  def initialize(secret)
    @rows = []
    @secret = secret
  end

  def make_guess(code)
    rows.unshift([code, secret.get_hint(code)])
  end

  def game_ended?
    rows.length == 10 || any_right_guess?
  end

  def any_right_guess?
    rows.any? do |row|
      code = row.first
      code == secret
    end
  end
end
