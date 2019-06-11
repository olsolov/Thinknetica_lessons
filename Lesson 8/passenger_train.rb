require_relative 'train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'


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
end
