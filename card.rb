class Card
  attr_accessor :suit, :value, :pointer

  def initialize(suit, value, pointer)
    @suit = suit
    @value = value
    @pointer = pointer
  end
end
