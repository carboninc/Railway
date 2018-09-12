# Checks For Railway
module Checks
  private

  def check_stations
    check_stations = proc do
      puts 'Список станций пуст или создана всего одна станция, создайте новую станцию!'
      separator
      stations_menu
    end
    check_stations.call if Station.all.nil? || Station.all.length < 2
  end

  def check_routes
    check_routes = proc do
      puts 'Список маршрутов пуст, создайте маршрут!'
      separator
      routes_menu
    end
    check_routes.call if Route.all.nil?
  end

  def check_trains
    check_trains = proc do
      puts 'Список поездов пуст, создайте поезд!'
      separator
      trains_menu
    end
    check_trains.call if Train.all.nil?
  end

  def check_of_identical_stations
    check_of_identical_stations = proc do
      puts 'Ошибка! Такая станция уже есть в списке, выберите другую.'
      separator
      add_station
    end
    check_of_identical_stations.call
  end

  def check_count_wagons_in_train
    check_count_wagons_in_train = proc do
      puts 'У данного поезда нет вагонов.'
      separator
      trains_menu
    end
    check_count_wagons_in_train.call if @selected_train.wagons.length.zero?
  end

  # Check Option In Menu
  def no_option_in_stations?(selected)
    selected > Station.all.length || selected < 1
  end

  def no_option_in_routes?(selected)
    selected > Route.all.length || selected < 1
  end

  def no_option_in_trains?(selected)
    selected > Train.all.length || selected < 1
  end

  def no_option_in_wagons?(selected)
    selected > Wagon.all.length || selected < 1
  end
end
