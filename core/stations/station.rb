# Railway Station
class Station
  include InstanceCounter
  include Validation

  attr_reader :name

  class << self
    attr_accessor :stations

    def all
      @stations
    end
  end

  validate :name, :presence
  validate :name, :name_length

  def initialize(name)
    @name = name
    @trains = []
    self.class.stations ||= {}
    validate!
    check_stations!
    self.class.stations[name] = self
    register_instance
  end

  def train_arrival(train)
    @trains.push(train)
  end

  def trains
    @trains.length
  end

  def trains_by_type
    passengers = @trains.select { |train| train.class.name == 'PassengerTrain' }
    cargos = @trains.select { |train| train.class.name == 'CargoTrain' }
    @trains_by_type = [passengers.length, cargos.length]
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def traverse_train
    @trains.each.with_index(1) { |train, index| yield(train, index) }
  end

  private

  def check_stations!
    self.class.stations.each_key do |key|
      return raise 'Такая станция уже существует' if key == name
    end
  end
end
