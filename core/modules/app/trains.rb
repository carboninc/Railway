# Trains Module
module Trains
  def create_train
    puts 'Укажите тип поезда:'

    puts ['1. Грузовой', '2. Пассажирский']
    select = gets.chomp.to_i

    create_cargo_or_passenger_train(select)

    puts 'Поезд создан!'
    trains_menu
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def add_train_route
    check_trains

    check_routes

    select_train(:add_train_route)

    select_route(:add_train_route)

    @selected_train.add_route(@selected_route)

    puts 'Маршрут добавлен!'
    trains_menu
  end

  def attach_wagon
    check_trains

    select_train(:attach_wagon)

    create_cargo_or_passenger_wagon

    @selected_train.add_wagon(@wagon)

    puts 'Вагон добавлен!'
    trains_menu
  end

  def unhook_wagon
    check_trains

    select_train(:unhook_wagon)

    check_count_wagons_in_train

    @selected_train.delete_wagon

    puts 'Вагон удален!'
    separator
    trains_menu
  end

  def wagons_list
    check_trains

    select_train(:select_train)

    check_count_wagons_in_train

    wagons_in_train

    separator
    trains_menu
  end

  def forward_train
    check_trains

    select_train(:forward_train)

    if @selected_train.route == ''
      puts 'Ошибка! Не назначен маршрут для этого поезда.'
      return trains_menu
    end
    move = @selected_train.move_forward

    puts "Поезд прибыл на станцию: #{move.name}"
    separator
    trains_menu
  end

  def backward_train
    check_trains

    select_train(:backward_train)

    if @selected_train.route == ''
      puts 'Ошибка! Не назначен маршрут для этого поезда.'
      return trains_menu
    end
    move = @selected_train.move_backward

    puts "Поезд прибыл на станцию: #{move.name}"
    separator
    trains_menu
  end

  def take_wagon_place_or_volume
    check_trains

    select_train(:take_wagon_place_or_volume)

    check_count_wagons_in_train

    select_wagon_in_train(:take_wagon_place_or_volume)

    take_place_or_volume_wagon

    separator
    trains_menu
  rescue RuntimeError => e
    puts "Ошибка: #{e}"
    trains_menu
  end

  private

  def create_number_manufacturer
    puts 'Укажите номер поезда в формате ...-.. (можно без дифиса), где точки любые буквы и цифры:'
    @number = gets.chomp.to_s
    puts 'Укажите производителя поезда:'
    @manufacturer = gets.chomp.to_s
  end

  def create_cargo_or_passenger_train(select)
    case select
    when 1
      create_number_manufacturer
      CargoTrain.new(@number, @manufacturer)
    when 2
      create_number_manufacturer
      PassengerTrain.new(@number, @manufacturer)
    else
      error_selecting_option(:create_train)
    end
  end
end
