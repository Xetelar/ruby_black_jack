class Game
  attr_accessor :current_player, :bank

  INTEGER = 21
  RATE = 10

  def initialize
    @interface = Interface.new
    @bank = 0
  end

  def start
    loop do
      @interface.show_start_menu
      action = gets.to_i
      break if action.zero?
      name = @interface.gets_name
      @user = User.new(name)
      @dealer = Dealer.new
      @interface.show_name(@user)
      sleep(1)
      start_game
    end
  end

  private

  def movie
    action = if @current_player == @user
               @interface.choose_movie
             else
               @current_player.movie
             end
    return open_cards if @user.hand.size == 3
    case action
    when 1
      take_card
    when 2
      skip_turn
    when 3
      open_cards
    when 4
      current_money
    when 5
      return
    else
      @interface.movie_error
      movie
    end
  end

  def start_game
    @block = Deck.new
    2.times do
      @user.hand.add(@block.add_card)
      @dealer.hand.add(@block.add_card)
    end
    @interface.show_player_cards(@user)
    @bank = RATE * 2
    @user.remove_money(RATE)
    @dealer.remove_money(RATE)
    @current_player = @user
    movie
  end

  def open_cards
    sum_cards_player = @user.sum_cards
    sum_cards_dealer = @dealer.sum_cards
    @interface.show_sum_card(@user)
    @interface.show_sum_card(@dealer)

    if sum_cards_player > INTEGER || (sum_cards_player < sum_cards_dealer && sum_cards_dealer < INTEGER)
      @interface.show_finish_text('loss')
      @dealer.add_money(@bank)
    elsif sum_cards_dealer > INTEGER || sum_cards_dealer < sum_cards_player
      @interface.show_finish_text('vin')
      @user.add_money(@bank)
    else
      @interface.show_finish_text
      @user.add_money(@bank / 2)
      @dealer.add_money(@bank / 2)
    end

    return if @user.money_zero? || @dealer.money_zero?

    @user.hand = Hand.new
    @dealer.hand = Hand.new
    sleep(1)
    start_game
  end

  def current_money
    @interface.show_player_money(@user)
    @interface.show_player_money(@dealer)
    sleep(1)
    movie
  end

  def skip_turn
    @interface.show_skip_turn(@current_player)
    change_player
    sleep(1)
    movie
  end

  def take_card
    @current_player.hand.add(@block.add_card)
    @interface.show_take_card(@current_player)
    change_player
    sleep(1)
    movie
  end

  def change_player
    @current_player = (@current_player == @user ? @dealer : @user)
  end
end
