# Cargo Wagon Class
class CargoWagon < Wagon
  attr_reader :free_volume, :busy_volume
  def initialize(manufacturer, volume)
    super('Cargo', manufacturer)
    @volume = volume
    @free_volume = volume
    @busy_volume = 0
  end

  def take_volume(value)
    volume = value.to_i
    check_volume!(volume)
    @free_volume -= volume
    @busy_volume += volume
  end

  private

  def check_volume!(value)
    raise 'Воздух гоняем?' if value.zero?
    raise 'Не хватает места' if @free_volume - value < 0
    true
  end
end
