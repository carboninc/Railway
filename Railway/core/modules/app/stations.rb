# Stations Module
module Stations
  def create_station
    separator

    puts 'Введите название станции:'
    station_name = gets.chomp.to_s
    Station.new(station_name)

    puts "Станция #{station_name} создана"
    separator
    stations_menu
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def show_stations
    puts 'Список станций:'

    if Station.all.empty?
      puts 'Список пуст'
      separator
      return stations_menu
    end

    Station.all.each_key.with_index(1) { |station, index| puts "#{index}. #{station}" }

    separator
    stations_menu
  end

  def show_trains
    check_stations
    check_trains

    puts 'Выберите станцию для вывода списка поездов:'
    select_station
    station = gets.chomp.to_i

    error_selecting_option(show_trains) if no_option_in_stations(station)

    selected_station = search_station(station)

    trains_list(selected_station)

    separator
    stations_menu
  end

  private

  def no_option_in_stations(selected)
    check_option = proc { selected > Station.all.length || selected < 1 }
    check_option.call
  end

  def search_station(station)
    station_names = Station.all.keys
    Station.all[station_names[station - 1]]
  end

  def trains_list(selected_station)
    puts 'Список поездов:'
    selected_station.traverse_train do |train, index|
      puts "#{index}. Поезд: #{train.number}. Тип: #{train.class.name}. \
       Кол-во вагонов: #{train.wagons.length}."
    end
  end
end
