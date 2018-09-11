# Module Menu For Railway
module Menu
  def start
    separator
    puts '1. Меню станций'
    puts '2. Меню маршрутов'
    puts '3. Меню поездов'
    puts '-----------'
    puts '0. Выход из программы'

    select = gets.chomp.to_s
    start_router(select)
  end

  def stations_menu
    separator
    puts '1. Создать станцию'
    puts '2. Показать список станций'
    puts '3. Показать список поездов на станции'
    puts '-----------'
    puts '0. Вернуться в главное меню'

    select = gets.chomp.to_s
    stations_menu_router(select)
  end

  def routes_menu
    separator
    puts '1. Создать маршрут'
    puts '2. Добавить станцию'
    puts '3. Удалить станцию'
    puts '4. Показать список маршрутов'
    puts '5. Показать список станций в маршруте'
    puts '-----------'
    puts '0. Вернуться в главное меню'

    select = gets.chomp.to_s
    routes_menu_router(select)
  end

  def trains_menu
    separator
    train_menu_block
    puts '-----------'
    wagon_menu_block
    puts '-----------'
    puts '0. Вернуться в главное меню'

    select = gets.chomp.to_s
    trains_menu_router(select)
  end

  private

  def train_menu_block
    puts '1. Создать поезд'
    puts '2. Назначить маршрут поезду'
    puts '3. Переместить поезд на следующую станцию'
    puts '4. Переместить поезд на предыдущую станцию'
  end

  def wagon_menu_block
    puts '5. Добавить вагон поезду'
    puts '6. Отцепить вагон от поезда'
    puts '7. Показать список вагонов у поезда'
    puts '8. Занять место или объем в вагоне'
  end
end
