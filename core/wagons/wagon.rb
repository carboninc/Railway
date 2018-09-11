# Wagons of trains. Types of wagons: passenger, cargo.
class Wagon
  include Manufacturer
  attr_reader :type, :number

  class << Wagon
    attr_accessor :wagons

    def all
      @wagons
    end
  end

  def initialize(type, manufacturer)
    @number = rand(0...999_999)
    @type = type
    @manufacturer = manufacturer.to_s
    Wagon.wagons ||= []
    validate!
    Wagon.wagons << self
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  private

  def validate!
    raise 'Укажите тип вагона: Cargo или Passenger' if type != 'Cargo' && type != 'Passenger'
    raise 'Укажите производителя вагона' if manufacturer.empty?
    true
  end
end
