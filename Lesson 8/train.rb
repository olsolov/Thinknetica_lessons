require_relative 'producer_company'
require_relative 'instance_counter'

class Train
  include ProducerCompany
  include InstanceCounter

  @@trains = {}

  attr_reader :number, :speed, :train_wagons, :current, :route

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-*[a-f0-9]{2}$/i

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @train_wagons = []
    @@trains[number] = self
    self.register_instance
  end

  def yield_trains_wagons
    @trains_wagons.each do |wagon|
      yield(wagon)
    end
  end 

  def valid?
    validate!
  rescue
    false
  end

  def self.find(find_number)
    @@trains[find_number]
  end

  def self.all
    @@trains.values
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
  def validate!
    # raise "Номер поезда не соответствует формату" if @number !~ NUMBER_FORMAT
  end

  def previous_station
    @route.list[@current - 1] if @current != 0
  end

  def next_station
    @route.list[@current + 1]
  end
end

# yield_trains_wagons {|x| puts "Вагон #{x}"}
t = PassengerTrain.new(11111)
w = PassengerWagon.new(10)
w1 = PassengerWagon.new(10)
t.accept_wagon(w)
t.accept_wagon(w1)
t.train_wagons
# t.yield_trains_wagons{|x| puts "Номер вагона: #{rand(10..99)}, тип вагона: #{x.type}"}
