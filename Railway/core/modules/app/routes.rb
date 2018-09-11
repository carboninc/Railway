module Routes
  def create_route
    check_stations

    select_start_station

    select_end_station

    Route.new(@start_station, @end_station)

    puts 'Маршрут создан!'
    separator
    routes_menu
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def add_station
    check_routes

    check_stations

    puts 'Выберите маршрут для добавления станции:'
    select_route
    select = gets.chomp.to_i
    if select > Route.all.length || select < 1
      puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
      separator
      return add_station
    end
    selected_route = Route.all[select - 1]

    puts 'Укажите название станции:'
    select_station
    new_station = gets.chomp.to_i
    if new_station > Station.all.length || new_station < 1
      puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
      separator
      return add_station
    end
    station_names = Station.all.keys
    selected_station = Station.all[station_names[new_station - 1]]

    if selected_station == selected_route.stations[new_station - 1]
      puts 'Ошибка! Такая станция уже есть в списке, выберите другую.'
      separator
      return routes_menu
    end

    selected_route.add_station(selected_station)

    puts 'Станция добавлена!'
    separator
    routes_menu
  end

  def delete_station
    check_routes

    check_stations

    puts 'Выберите маршрут для удаления станции:'
    select_route
    select = gets.chomp.to_i
    if select > Route.all.length || select < 1
      puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
      separator
      return delete_station
    end
    selected_route = Route.all[select - 1]

    puts 'Укажите название станции:'
    selected_route.stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
    select_station = gets.chomp.to_i
    if select_station > selected_route.stations.length || select_station < 1
      puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
      separator
      return delete_station
    end
    selected_delete_station = selected_route.stations[select_station - 1]

    if selected_delete_station == selected_route.stations.first || selected_delete_station == selected_route.stations.last
      puts 'Ошибка! Данную станцию нельзя удалить.'
      separator
      return routes_menu
    end
    selected_route.delete_station(selected_delete_station)

    puts 'Станция удалена!'
    separator
    routes_menu
  end

  def show_stations_in_route
    check_routes

    puts 'Выберите маршрут для просмотра списка станций:'
    select_route
    selected_route = gets.chomp.to_i
    if selected_route > Route.all.length || selected_route < 1
      puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
      separator
      return show_stations_in_route
    end

    puts 'Станции выбранного маршрута:'
    Route.all[selected_route - 1].stations.each do |station|
      puts station.name
    end

    separator
    routes_menu
  end

  private

  def select_start_station
    puts 'Выберите начальную станцию маршрута:'
    select_station
    selected_start_station = gets.chomp.to_i

    error_selecting_option(create_route) if no_option_in_stations(selected_start_station)

    @start_station = search_station(selected_start_station)
  end

  def select_end_station
    puts 'Выберите конечную станцию маршрута:'
    select_station
    selected_end_station = gets.chomp.to_i

    error_selecting_option(create_route) if no_option_in_stations(selected_end_station)

    @end_station = search_station(selected_end_station)
  end

  def select_route
    Route.all.each.with_index(1) do |route, index|
      puts "#{index}. / Маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
    end
  end

  def show_routes
    puts 'Список маршрутов:'
    select_route
    separator
    routes_menu
  end

  def select_station
    Station.all.each.with_index(1) { |name, index| puts "#{index}. #{name}" }
  end
end
