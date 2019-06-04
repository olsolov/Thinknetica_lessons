require_relative 'train'

class PassengerTrain < Train
  attr_reader :type

  @trains = []

  def initialize(number)
    self.class.trains << self
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
