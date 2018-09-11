# Trains Routes
class Route
  include InstanceCounter
  attr_reader :stations

  class << self
    attr_accessor :routes

    def all
      @routes
    end
  end

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    self.class.routes ||= []
    self.class.routes << self
    register_instance
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def add_station(name_station)
    @stations.insert(-2, name_station)
  end

  def delete_station(name_station)
    @stations.delete_at(@stations.find_index(name_station))
  end

  private

  def validate!
    @stations.each do |station|
      return raise 'Требуются экземпляры класса Station' unless station.is_a?(Station)
    end
    raise 'Станция не может быть одновременно начальной и конечной' if @stations[0] == @stations[-1]
    true
  end
end
