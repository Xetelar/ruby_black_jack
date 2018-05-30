class Player
  def self.sum_cards(player)
    player.cards.sum { |card| card[:number] }
  end

  attr_accessor :cards, :name

  def initialize(name, money = 100)
    @name = name
    @money = money
    @cards = []
  end

  def add_card(card)
    @cards << card
    card[:value]
  end

  def puts_card
    puts 'Ваши карты'
    cards.each { |card| puts card[:value] }
  end

  def remove_money(value = 10)
    @money -= value
  end

  def add_money(value)
    @money += value
  end

  def money_zero?
    @money <= 0
  end
end
