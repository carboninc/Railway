# Checks For Railway
module Checks
  private

  def check_stations
    check_stations = proc {
      puts 'Список станций пуст или создана всего одна станция, создайте новую станцию!'
      separator
      stations_menu
    }
    check_stations.call if Station.all.nil? || Station.all.length < 2
  end

  def check_routes
    check_routes = proc {
      puts 'Список маршрутов пуст, создайте маршрут!'
      separator
      routes_menu
    }
    check_routes.call if Route.all.nil?
  end

  def check_trains
    check_trains = proc {
      puts 'Список поездов пуст, создайте поезд!'
      separator
      trains_menu
    }
    check_trains.call if Train.all.nil?
  end

  def separator
    puts '-----------'
    puts ''
  end
end