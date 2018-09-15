# Shared Modules
require_relative 'core/modules/manufacturer'
require_relative 'core/modules/instance_counter'
require_relative 'core/modules/accessors.rb'
require_relative 'core/modules/validation.rb'

# Menu Module
require_relative 'core/modules/menu/menu'

# Routing Module
require_relative 'core/modules/routing/routing'

# App Modules
require_relative 'core/modules/app/stations'
require_relative 'core/modules/app/routes'
require_relative 'core/modules/app/trains'
require_relative 'core/modules/app/wagons'

# Check Methods Module
require_relative 'core/modules/checks'

# Helpers Methods Module
require_relative 'core/modules/helpers'

# Classes
require_relative 'core/stations/station'

require_relative 'core/routes/route'

require_relative 'core/trains/train'
require_relative 'core/trains/passenger_train'
require_relative 'core/trains/cargo_train'

require_relative 'core/wagons/wagon'
require_relative 'core/wagons/passenger_wagon'
require_relative 'core/wagons/cargo_wagon'
# ------------------------------------------------------------------
class Railway
  include Menu
  include Routing
  include Stations
  include Routes
  include Trains
  include Wagons
  include Checks
  include Helpers
end

puts 'Добро пожаловать в программу по управлению железнодорожной станцией!'

Railway.new.start
