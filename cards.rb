class Cards
  attr_accessor :cards, :cards_number

  def initialize
    @cards = []
    @cards_number = 52
    lears = %w[+ <3 ^ <>]
    lears.each do |learn|
      (2..10).each do |i|
        @cards << {
          value: "#{i}#{learn}",
          number: i
        }
      end
      %w[J Q K A].each do |a|
        @cards << {
          value: "#{a}#{learn}",
          number: a == 'A' ? 11 : 10
        }
      end
    end
  end

  def add_card
    random_rand = Random.rand(@cards_number)
    card = @cards[random_rand - 1]
    @cards.delete_at(random_rand)
    remove_card
    card
  end

  def remove_card
    @cards_number -= 1
  end
end
