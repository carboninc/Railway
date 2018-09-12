# Private Wagons Methods
module Wagons
  private

  def create_manufacturer_wagon
    puts 'Укажите производителя вагона:'
    @manufacturer = gets.chomp.to_s
  end

  def wagon_places
    puts 'Укажите объем вагона:'
    @places = gets.chomp.to_i
  end

  def wagon_volume
    puts 'Укажите кол-во пассажирских мест в вагоне:'
    @volume = gets.chomp.to_i
  end

  def create_cargo_or_passenger_wagon
    create_manufacturer_wagon
    if @selected_train.class.name == 'CargoTrain'
      wagon_places
      @wagon = CargoWagon.new(@manufacturer, @places)
    else
      wagon_volume
      @wagon = PassengerWagon.new(@manufacturer, @volume)
    end
  end

  def take_place_or_volume_wagon
    if @selected_wagon.is_a? PassengerWagon
      @selected_wagon.take_place
      puts 'Вы заняли одно пассажирское место:'
    else
      puts 'Укажите объем, который вы хотите занять:'
      @value = gets.chomp.to_i
      @selected_wagon.take_volume(@value)
      puts 'Объем занят:'
    end
  end
end
