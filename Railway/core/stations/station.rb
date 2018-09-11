# Railway Station
class Station
  include InstanceCounter

  attr_reader :name

  class << self
    attr_accessor :stations

    def all
      @stations
    end
  end

  def initialize(name)
    @name = name.to_s
    @trains = []
    self.class.stations ||= {}
    validate!
    self.class.stations[name] = self
    register_instance
  end

  def valid?
    validate!
  rescue RuntimeError
    false
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

  def validate!
    raise 'Название станции не может быть пустым' if name.empty?
    raise 'Название станции должно быть не менее 3 символов' if name.length < 3
    self.class.stations.each_key do |key|
      return raise 'Такая станция уже существует' if key == name
    end
  end
end
