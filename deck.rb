class Deck
  attr_accessor :cards

  SUITS = %w[+ <3 ^ <>].freeze
  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize
    @cards = []
    make_deck!
    shuffle!
  end

  def add_card
    @cards.pop
  end

  private

  def make_deck!
    VALUES.each do |value|
      SUITS.each do |suit|
        value_i = value.to_i
        number = if value == 'A'
                   11
                 else
                   value_i.zero? ? 10 : value_i
                 end
        @cards << Card.new("#{value}#{suit}", number, value)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
  end
end
