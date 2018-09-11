# Cargo Train. Advanced method of adding wagons
class CargoTrain < Train
  def add_wagon(wagon)
    super if wagon.type == 'Cargo'
  end
end
