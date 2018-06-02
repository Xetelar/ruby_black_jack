class Player
  attr_accessor :name, :money, :hand

  def initialize(name, money = 100)
    @name = name
    @money = money
    @hand = Hand.new
  end

  def add_money(value)
    @money += value
  end

  def remove_money(value)
    @money -= value
  end

  def money_zero?
    @money <= 0
  end

  def sum_cards
    sum = 0
    cards_a = []
    @hand.cards.each do |card|
      if card.pointer != 'A'
        sum += card.value
      else
        cards_a << card
      end
    end
    cards_a.each do
      puts sum + 11 > 21
      sum += sum + 11 > 21 ? 1 : 11
    end
    sum
  end
end
