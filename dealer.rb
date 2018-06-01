class Dealer < Player
  def initialize()
    super('Диллер')
  end

  def movie
    sum_cards > 17 || @hand.size == 3 ? 2 : 1
  end
end
