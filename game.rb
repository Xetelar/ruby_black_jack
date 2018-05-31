class Game
  attr_accessor :current_player

  INTEGER = 21

  def initialize
    @interface = Interface.new
    @bank = 0
    @block = Deck.new
  end

  def start
    loop do
      @interface.show_start_menu
      action = gets.to_i
      break if action.zero?
      name = @interface.gets_name
      @user = User.new(name)
      @dealer = Dealer.new
      @user.show_name
      start_game
    end
  end

  private

  def movie
    action = @current_player.movie
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
      puts 'Введите число от 1 до 4'
      movie
    end
  end

  def start_game
    2.times do
      @user.hand.add(@block.add_card)
      @dealer.hand.add(@block.add_card)
    end
    puts 'Ваши карты'
    @user.hand.show
    @bank = 20
    @current_player = @user
    movie
  end

  def open_cards
    sum_cards_player = @user.sum_cards
    sum_cards_dealer = @dealer.sum_cards
    @user.show_sum_card
    @dealer.show_sum_card

    if sum_cards_player > INTEGER || sum_cards_player < sum_cards_dealer
      puts '======= Вы проиграли ======='
      @dealer.add_money(@bank)
    elsif sum_cards_dealer > INTEGER || sum_cards_dealer < sum_cards_player
      puts '======= Вы выйграли ======='
      @user.add_money(@bank)
    else
      puts '======= Ничья ======='
      @user.add_money(@bank / 2)
      @dealer.add_money(@bank / 2)
    end

    if @user.money_zero? || @dealer.money_zero?
      return start
    end

    @user.hand = Hand.new
    @dealer.hand = Hand.new
    start_game
  end

  def current_money
    puts "======= У Вас #{@user.money}$ ======="
    puts "======= У диллера #{@dealer.money}$ ======="
    movie
  end

  def skip_turn
    puts "#{@current_player} пропустил ход"
    change_player
    movie
  end

  def take_card
    @current_player.hand.add(@block.add_card)
    @current_player.hand.show
    puts "#{@current_player} взял карту"
    change_player
    movie
  end

  def change_player
    @current_player = (@current_player == @user ? @dealer : @user)
  end
end
