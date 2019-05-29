require_relative './train'

class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end

  def accept_wagon(wagon)
    if @speed == 0 && wagon.type == :passenger
      unless @train_wagons.include?(wagon)
        @train_wagons << wagon 
      end
    end
  end

  def remove_wagon(wagon)
    @train_wagons.delete(wagon) if @speed == 0
  end
end
