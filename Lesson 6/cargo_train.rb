require_relative 'train'

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :cargo
  end

  def accept_wagon(wagon)
    if @speed == 0 && wagon.type == :cargo
      unless @train_wagons.include?(wagon)
        @train_wagons << wagon 
      end
    end
  end
end

# проверка
# t1 = CargoTrain.new(111)
# t2 = CargoTrain.new(222)
# p CargoTrain.instances
