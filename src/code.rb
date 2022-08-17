class Code
  def self.from_text(text)
    code_elements = text.split("").map { |c| self.get_element(c) }.select { |v| !!v }
    Code.new(*code_elements)
  end

  private_class_method def self.get_element(character)
    ("A".."H").to_a.find_index(character.upcase)
  end

  attr_reader :value

  def initialize(*elements)
    @value = elements
  end

  def ==(code)
    value == code.value
  end

  def get_hint(code)
    hint = []
    code.value.each_with_index do |e, i|
      if value[i] == e
        hint.push(2)
      elsif value.include?(e)
        hint.push(1)
      else
        hint.push(0)
      end
    end
    hint.sort.reverse
  end
end
