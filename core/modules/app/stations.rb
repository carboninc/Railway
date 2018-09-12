# Stations Module
module Stations
  def create_station
    separator

    puts 'Введите название станции:'
    station_name = gets.chomp.to_s
    Station.new(station_name)

    separator
    puts "Станция #{station_name} создана"
    stations_menu
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def show_stations
    separator
    puts 'Список станций:'

    if Station.all.empty?
      puts 'Список пуст'
      separator
      return stations_menu
    end

    Station.all.each_key.with_index(1) { |station, index| puts "#{index}. #{station}" }

    stations_menu
  end

  def show_trains
    check_stations

    check_trains

    select_station(:show_trains)

    trains_list_in_station(selected_station)

    separator
    stations_menu
  end

  private

  def trains_list_in_station(selected_station)
    puts 'Список поездов:'
    selected_station.traverse_train do |train, index|
      puts "#{index}. Поезд: #{train.number}. Тип: #{train.class.name}. \
       Кол-во вагонов: #{train.wagons.length}."
    end
  end
end
