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

  def money_zero?
    @money <= 0
  end

  def sum_cards
    sum = 0
    @hand.cards.each do |card|
      if card.pointer != 'A'
        sum += card.value
      else
        sum = sum + 11 > 21 ? 1 : 11
      end
    end
    sum
  end

  def show_sum_card
    puts "Количество очков #{@name}: #{sum_cards}"
  end
end
