class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add(card)
    @cards << card
    card.value
  end

  def size
    @cards.length
  end
end
