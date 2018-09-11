# Passenger Wagon Class
class PassengerWagon < Wagon
  attr_reader :busy_places, :free_places
  def initialize(manufacturer, places)
    super('Passenger', manufacturer)
    @places = places
    @free_places = places
    @busy_places = 0
  end

  def take_place
    check_places!
    @free_places -= 1
    @busy_places += 1
  end

  private

  def check_places!
    raise 'Кол-во свободных мест в вагоне закончилось!' if @free_places.zero?
    true
  end
end
