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
end
