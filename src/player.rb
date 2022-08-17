class Player
  attr_reader :name

  def initialize(name, input_method)
    @name = name
    @input_method = input_method
  end

  def get_code
    input_method.get
  end

  private

  def input_method
    @input_method
  end
end
