class AIInput
  def get
    result = []
    while result.length < 4 do
      new_char = get_random_character
      result.push(new_char) unless result.include?(new_char)
    end
    result.join
  end

  private
  
  def get_random_character
    (65 + rand(8)).chr
  end
end
