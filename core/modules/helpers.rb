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

  # Search: Station, Train
  def search_station(station)
    station_names = Station.all.keys
    Station.all[station_names[station - 1]]
  end

  def search_train(train)
    train_numbers = Train.all.keys
    Train.all[train_numbers[train - 1]]
  end

  # Lists: Trains, Routes, Stations
  def routes_list
    Route.all.each.with_index(1) do |(route), index|
      puts "#{index}. Маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
    end
  end

  def stations_list
    Station.all.each.with_index(1) { |(name), index| puts "#{index}. #{name}" }
  end

  def trains_list
    Train.all.each.with_index(1) { |(train), index| puts "#{index}. Номер поезда: #{train}" }
  end

  def wagons_in_train
    puts 'Список вагонов:'
    @selected_train.traverse_wagon do |wagon, index|
      if wagon.is_a? PassengerWagon
        puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}." \
            "Кол-во свободных мест: #{wagon.free_places}. Кол-во занятых мест: #{wagon.busy_places}"
      else
        puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}." \
            "Свободный объем: #{wagon.free_volume}. / Занятый объем: #{wagon.busy_volume}"
      end
    end
  end

  # Select: Station, Route, Train
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

  def select_train(return_route)
    puts 'Выберите поезд:'
    trains_list
    @train = gets.chomp.to_i

    error_selecting_option(return_route) if no_option_in_trains?(@train)

    @selected_train = search_train(@train)
  end

  def select_wagon_in_train(return_route)
    puts 'Выберите вагон для занятия места или объема:'
    wagons_in_train
    @wagon = gets.chomp.to_i

    error_selecting_option(return_route) if no_option_in_wagons?(@wagon)

    @selected_wagon = @selected_train.wagons[@wagon - 1]
  end

  # Other
  def separator
    puts '-----------'
    puts ''
  end
end
