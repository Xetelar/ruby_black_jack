require_relative 'player.rb'
require_relative 'cards.rb'

class Main
  def start
    loop do
      puts '
      =====================================
        Выбирите действие:
        1  - Начать игру с начала
        0  - Выход
      ====================================='
      action = gets.to_i
      break if action.zero?
      puts 'Введите ваше имя'
      name = gets.chomp
      @player = Player.new(name)
      @dealer = Player.new('Dealer')

      puts "
        =====================================
         #{name}, игра началась!
        ====================================="
      start_game
    end
  end

  private

  attr_accessor :player, :dealer, :block, :bank

  def start_game
    @block = Cards.new
    2.times do
      add_card(@player)
      add_card(@dealer)
    end
    @player.puts_card
    @bank = 20
    @player.remove_money
    @dealer.remove_money
    player_movie
  end

  def add_card(player)
    player.add_card(@block.add_card)
  end

  def miss_movie(player)
    send("#{player}_movie")
  end

  def player_movie
    return open_cards if @player.cards.length == 3

    puts '
      =====================================
        Выбирите действие:
        1  - Добавить карту
        2  - Пропустить ход
        3  - Открыть карты
        4  - Проверить текущее кол-во денег
        0  - Новая игра
      ====================================='
    action = gets.to_i
    return if action.zero?
    case action
    when 1
      new_card = add_card(@player)
      puts new_card
      @player.puts_card
      miss_movie('player')
    when 2
      miss_movie('dealer')
    when 3
      open_cards
    when 4
      current_money
    else
      puts 'Введите число от 0 до 3'
      player_movie
    end
  end

  def dealer_movie
    cards = @dealer.cards
    return miss_movie('player') if cards.sum(&:number) > 17 || cards.length == 3
    add_card(@dealer)
    miss_movie('player')
  end

  def open_cards
    sum_cards_player = Player.sum_cards(@player)
    sum_cards_dealer = Player.sum_cards(@dealer)
    puts "Количество выших очков: #{sum_cards_player}"
    puts "Количество очков у диллера: #{sum_cards_dealer}"

    if sum_cards_player > 21 || sum_cards_player < sum_cards_dealer
      puts '======= Вы проиграли ======='
      @dealer.add_money(@bank)
    elsif sum_cards_dealer > 21 || sum_cards_dealer < sum_cards_player
      puts '======= Вы выйграли ======='
      @player.add_money(@bank)
    else
      puts '======= Ничья ======='
      @player.add_money(@bank / 2)
      @dealer.add_money(@bank / 2)
    end

    if @player.money_zero? || @dealer.money_zero?
      puts 909
      return start
    end

    @player.cards = []
    @dealer.cards = []
    @bank = 0
    start_game
  end

  def current_money
    puts "======= У Вас #{@player.money}$ ======="
    puts "======= У диллера #{@dealer.money}$ ======="
    player_movie
  end
end

Main.new.start
