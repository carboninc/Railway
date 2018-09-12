# Module Routes
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

    select_route(:add_station)

    select_station(:add_station)

    check_of_identical_stations if @selected_station == @selected_route.stations[@station - 1]

    @selected_route.add_station(@selected_station)

    puts 'Станция добавлена!'
    separator
    routes_menu
  end

  def delete_station
    check_routes

    check_stations

    select_route(:delete_station)

    puts 'Укажите название станции:'
    select_station_in_route

    check_first_and_last_station

    @selected_route.delete_station(@selected_delete_station)

    puts 'Станция удалена!'
    separator
    routes_menu
  end

  def show_routes
    puts 'Список маршрутов:'
    routes_list
    separator
    routes_menu
  end

  def show_stations_in_route
    check_routes

    puts 'Выберите маршрут для просмотра списка станций:'
    routes_list
    route = gets.chomp.to_i
    error_selecting_option(:show_stations_in_route) if no_option_in_routes?(route)

    stations_of_selected_route(route)

    separator
    routes_menu
  end

  private

  def stations_of_selected_route(route)
    puts 'Станции выбранного маршрута:'
    Route.all[route - 1].stations.each do |station|
      puts station.name
    end
  end

  def select_start_station
    puts 'Выберите начальную станцию маршрута:'
    stations_list
    selected_start_station = gets.chomp.to_i

    error_selecting_option(:create_route) if no_option_in_stations?(selected_start_station)

    @start_station = search_station(selected_start_station)
  end

  def select_end_station
    puts 'Выберите конечную станцию маршрута:'
    stations_list
    selected_end_station = gets.chomp.to_i

    error_selecting_option(:create_route) if no_option_in_stations?(selected_end_station)

    @end_station = search_station(selected_end_station)
  end

  def stations_list_in_route
    @selected_route.stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
  end

  def select_station_in_route
    stations_list_in_route
    station = gets.chomp.to_i
    if station > @selected_route.stations.length || station < 1
      puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
      separator
      return delete_station
    end
    @selected_delete_station = @selected_route.stations[station - 1]
  end

  def check_first_and_last_station
    first_station = @selected_route.stations.first
    last_station = @selected_route.stations.last
    stations = @selected_route.stations

    check_station = proc do
      puts 'Ошибка! Данную станцию нельзя удалить.'
      separator
      routes_menu
    end
    check_station.call if stations.include?(first_station) || stations.include?(last_station)
  end
end
