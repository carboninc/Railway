# Trains Module
module Trains
  def create_train
    puts 'Укажите тип поезда:'

    puts '1. Грузовой'
    puts '2. Пассажирский'
    select = gets.chomp.to_i

    case select
    when 1
      puts 'Укажите номер поезда в формате ...-.. (можно без дифиса), где точки любые буквы и цифры:'
      number = gets.chomp.to_s
      puts 'Укажите производителя поезда:'
      manufacturer = gets.chomp.to_s
      CargoTrain.new(number, manufacturer)
    when 2
      puts 'Укажите номер поезда в формате ...-.. (можно без дифиса), где точки любые буквы и цифры:'
      number = gets.chomp.to_s
      puts 'Укажите производителя поезда:'
      manufacturer = gets.chomp.to_s
      PassengerTrain.new(number, manufacturer)
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      separator
      create_train
    end

    puts 'Поезд создан!'
    separator
    trains_menu
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def add_train_route
    check_trains

    check_routes

    puts 'Выберите поезд для назначения ему маршрута:'
    select_train
    train = gets.chomp.to_i
    if train > Train.all.length || train < 1
      puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
      separator
      return add_train_route
    end
    train_numbers = Train.all.keys
    selected_train = Train.all[train_numbers[train - 1]]

    puts 'Выберите маршрут для назначения его поезду:'
    select_route
    route = gets.chomp.to_i
    if route > Route.all.length || route < 1
      puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
      separator
      return add_train_route
    end
    selected_route = Route.all[route - 1]

    selected_train.add_route(selected_route)

    puts 'Маршрут добавлен!'
    separator
    trains_menu
  end

  def attach_wagon
    check_trains

    puts 'Выберите поезд для добавления вагона'
    select_train
    train = gets.chomp.to_i
    if train > Train.all.length || train < 1
      puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
      separator
      return attach_wagon
    end
    train_numbers = Train.all.keys
    selected_train = Train.all[train_numbers[train - 1]]

    if selected_train.class.name == 'CargoTrain'
      puts 'Укажите производителя вагона:'
      manufacturer = gets.chomp.to_s
      puts 'Укажите объем вагона:'
      places = gets.chomp.to_i
      wagon = CargoWagon.new(manufacturer, places)
    else
      puts 'Укажите производителя вагона:'
      manufacturer = gets.chomp.to_s
      puts 'Укажите кол-во пассажирских мест в вагоне:'
      volume = gets.chomp.to_i
      wagon = PassengerWagon.new(manufacturer, volume)
    end
    selected_train.add_wagon(wagon)

    puts 'Вагон добавлен!'
    separator
    trains_menu
  end

  def unhook_wagon
    check_trains

    puts 'Выберите поезд для удаления вагона'
    select_train
    train = gets.chomp.to_i
    if train > Train.all.length || train < 1
      puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
      separator
      return unhook_wagon
    end
    train_numbers = Train.all.keys
    selected_train = Train.all[train_numbers[train - 1]]

    if selected_train.wagons.length.zero?
      puts 'У данного поезда нет вагонов.'
      separator
      return trains_menu
    end

    selected_train.delete_wagon

    puts 'Вагон удален!'
    separator
    trains_menu
  end

  def wagons_list
    check_trains

    puts 'Выберите поезд для просмотра списка вагонов:'
    select_train
    train = gets.chomp.to_i
    if train > Train.all.length || train < 1
      puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
      separator
      return select_train
    end
    train_numbers = Train.all.keys
    selected_train = Train.all[train_numbers[train - 1]]

    if selected_train.wagons.length.zero?
      puts 'У данного поезда нет вагонов.'
      separator
      return trains_menu
    end

    puts 'Список вагонов:'
    selected_train.traverse_wagon do |wagon, index|
      if wagon.is_a? PassengerWagon
        puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}. Кол-во свободных мест: #{wagon.free_places}. Кол-во занятых мест: #{wagon.busy_places}"
      else
        puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}. Кол-во свободного объема: #{wagon.free_volume}. Кол-во занятого объема: #{wagon.busy_volume}"
      end
    end
    separator
    trains_menu
  end

  def forward_train
    check_trains

    puts 'Выберите поезд для движения к следующей станции:'
    select_train
    train = gets.chomp.to_i
    if train > Train.all.length || train < 1
      puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
      separator
      return forward_train
    end

    train_numbers = Train.all.keys
    selected_train = Train.all[train_numbers[train - 1]]
    if selected_train.route == ''
      puts 'Ошибка! Не назначен маршрут для этого поезда.'
      separator
      return trains_menu
    end
    move = selected_train.move_forward

    puts "Поезд прибыл на станцию: #{move.name}"
    separator
    trains_menu
  end

  def backward_train
    check_trains

    puts 'Выберите поезд для движения к предыдущей станции:'
    select_train
    train = gets.chomp.to_i
    if train > Train.all.length || train < 1
      puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
      separator
      return backward_train
    end

    train_numbers = Train.all.keys
    selected_train = Train.all[train_numbers[train - 1]]
    if selected_train.route == ''
      puts 'Ошибка! Не назначен маршрут для этого поезда.'
      separator
      return trains_menu
    end
    move = selected_train.move_backward

    puts "Поезд прибыл на станцию: #{move.name}"
    separator
    trains_menu
  end

  def take_wagon_place_or_volume
    check_trains

    puts 'Выберите поезд для просмотра списка вагонов:'
    select_train
    train = gets.chomp.to_i
    if train > Train.all.length || train < 1
      puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
      separator
      return select_train
    end
    train_numbers = Train.all.keys
    selected_train = Train.all[train_numbers[train - 1]]

    if selected_train.wagons.length.zero?
      puts 'У данного поезда нет вагонов.'
      separator
      return trains_menu
    end

    puts 'Выберите вагон для занятия места или объема:'
    selected_train.traverse_wagon do |wagon, index|
      if wagon.is_a? PassengerWagon
        puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}. Кол-во свободных мест: #{wagon.free_places}. Кол-во занятых мест: #{wagon.busy_places}"
      else
        puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}. Кол-во свободного объема: #{wagon.free_volume}. Кол-во занятого объема: #{wagon.busy_volume}"
      end
    end
    wagon = gets.chomp.to_i
    if wagon > Wagon.all.length || wagon < 1
      puts 'Ошибка! Такого вагона нет, попробуйте еще раз.'
      separator
      return take_wagon_place_or_volume
    end
    selected_wagon = selected_train.wagons[wagon - 1]

    if selected_wagon.is_a? PassengerWagon
      selected_wagon.take_place
      puts 'Вы заняли одно пассажирское место:'
    else
      puts 'Укажите объем, который вы хотите занять:'
      value = gets.chomp.to_i
      selected_wagon.take_volume(value)
      puts 'Объем занят:'
    end
    separator
    trains_menu
  rescue RuntimeError => e
    puts "Ошибка: #{e}"
    trains_menu
  end
end
