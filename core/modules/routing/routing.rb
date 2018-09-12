# Routing For Railway
module Routing
  START_ROUTER = {
    '1' => :stations_menu,
    '2' => :routes_menu,
    '3' => :trains_menu,
    '0' => :exit
  }.freeze

  STATIONS_MENU_ROUTER = {
    '1' => :create_station,
    '2' => :show_stations,
    '3' => :show_trains,
    '0' => :start
  }.freeze

  ROUTES_MENU_ROUTER = {
    '1' => :create_route,
    '2' => :add_station,
    '3' => :delete_station,
    '4' => :show_routes,
    '5' => :show_stations_in_route,
    '0' => :start
  }.freeze

  TRAINS_MENU_ROUTER = {
    '1' => :create_train,
    '2' => :add_train_route,
    '3' => :forward_train,
    '4' => :backward_train,
    '5' => :attach_wagon,
    '6' => :unhook_wagon,
    '7' => :wagons_list,
    '8' => :take_wagon_place_or_volume,
    '0' => :start
  }.freeze

  def start_router(select)
    start = START_ROUTER[select] || error_selecting_option(:start)
    send(start)
  end

  def stations_menu_router(select)
    stations_menu = STATIONS_MENU_ROUTER[select] || error_selecting_option(:stations_menu)
    send(stations_menu)
  end

  def routes_menu_router(select)
    routes_menu = ROUTES_MENU_ROUTER[select] || error_selecting_option(:routes_menu)
    send(routes_menu)
  end

  def trains_menu_router(select)
    trains_menu = TRAINS_MENU_ROUTER[select] || error_selecting_option(:trains_menu)
    send(trains_menu)
  end

  private

  def exit
    exit = proc { abort('Всего доброго!') }
    exit.call
  end
end
