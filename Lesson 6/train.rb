require_relative 'producer_company'
require_relative 'instance_counter'

class Train
  include ProducerCompany
  include InstanceCounter

  @trains = []

  class << self
    attr_reader :trains
  end

  attr_reader :number, :speed, :train_wagons

  def initialize(number)
    @number = number
    @speed = 0
    @train_wagons = []
    self.class.trains << self
    self.register_instance
  end

  def self.find(find_number)
    find = self.trains.find {|train| train.number == find_number}
    p find
  end

  def speed=(speed)
    @speed = speed
    @speed = 0 if @speed < 0 
  end

  def stop
    @speed = 0
  end

  def add_route(route)
    @route = route
    @current = 0 unless @route.nil?
  end

  def remove_wagon(wagon)
    @train_wagons.delete(wagon) if @speed == 0
  end
  
  def current_station
    @route.list[@current]
  end

  def move_to_previous_station
    @current -=1 if previous_station
  end

  def move_to_next_station
    @current +=1 if next_station
  end

  protected
  # сделала эти методы protected,
  # т.к. напрямую они не вызываются,
  # являются вспомогательными

  def previous_station
    @route.list[@current - 1] if @current != 0
  end

  def next_station
    @route.list[@current + 1]
  end
end

# проверка
# t1 = Train.new(111)
# t2 = Train.new(222)
# Train.find(111)
# Train.find(222)
# Train.find(333)
