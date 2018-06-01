class Interface
  def show_start_menu
    puts '
      =====================================
        Выбирите действие:
        1  - Начать игру с начала
        0  - Выход
      ====================================='
  end

  def gets_name
    puts 'Введите ваше имя'
    gets.chomp
  end

  def choose_movie
    puts '
      =====================================
        Выбирите действие:
        1  - Добавить карту
        2  - Пропустить ход
        3  - Открыть карты
        4  - Проверить текущее кол-во денег
        5  - Завершить игру
      ====================================='
    gets.to_i
  end

  def show_name(player)
    puts "
        =====================================
         #{player.name}, игра началась!
        ====================================="
  end

  def show_player_cards(player)
    puts "Карты #{player.name}:"
    player.hand.cards.each do |card|
      puts "card: #{card.suit} - #{card.value} очков"
    end
  end

  def movie_error
    puts 'Введите число от 1 до 4'
  end

  def show_sum_card(player)
    puts "Количество очков #{player.name}: #{player.sum_cards}"
  end

  def show_take_card(player)
    puts "#{player.name} взял карту"
  end

  def show_skip_turn(player)
    puts "#{player} пропустил ход"
  end

  def show_player_money(player)
    puts "======= У #{player.name} #{player.money}$ ======="
  end

  def show_finish_text(status = '')
    text = if status == 'vin'
             '======= Вы выйграли ======='
           elsif status == 'loss'
             '======= Вы проиграли ======='
           else
             '======= Ничья ======='
           end
    puts text
  end
end
