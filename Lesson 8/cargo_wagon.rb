require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :busy_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @type = :cargo
    @busy_volume = 0
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end 

  def take_volume(volume)
    @busy_volume += volume unless @busy_volume == @total_volume 
  end

  def available_volume
    @total_volume - @busy_volume
  end

  protected
  def validate!
    raise 'У вагона должен быть общий объем' unless @total_volume > 0
  end
end
