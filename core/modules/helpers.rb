# Helpers Methods For Railway
module Helpers
  private

  # Error Handler
  def error_selecting_option(route)
    error = lambda do
      puts 'Ошибка ввода, попробуйте заново.'
      separator
      send(route)
    end
    error.call
  end

  # Search: Station
  def search_station(station)
    station_names = Station.all.keys
    Station.all[station_names[station - 1]]
  end

  # Lists: Trains, Routes, Stations
  def routes_list
    Route.all.each.with_index(1) do |route, index|
      puts "#{index}. / Маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
    end
  end

  def stations_list
    Station.all.each.with_index(1) { |name, index| puts "#{index}. #{name}" }
  end

  def trains_list
    Train.all.each.with_index(1) { |train, index| puts "#{index}. Номер поезда: #{train[0]}" }
  end

  # Select: Stations, Routes
  def select_route(return_route)
    puts 'Выберите маршрут:'
    routes_list
    @route = gets.chomp.to_i

    error_selecting_option(return_route) if no_option_in_routes?(@route)

    @selected_route = Route.all[@route - 1]
  end

  def select_station(return_route)
    puts 'Выберите станцию:'
    stations_list
    @station = gets.chomp.to_i

    error_selecting_option(return_route) if no_option_in_stations?(@station)

    @selected_station = search_station(@station)
  end

  # Other
  def separator
    puts '-----------'
    puts ''
  end
end
