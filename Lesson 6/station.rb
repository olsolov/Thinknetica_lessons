require_relative 'instance_counter'

class Station
  include InstanceCounter

  @stations = []

  class << self
    attr_reader :stations
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    self.class.stations << self
  end

  def self.all
    p self.stations
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_types
    types =[]
    trains_types = {}
   
    @trains.each do |train|
      types << train.type
      types.each do |item|
        trains_types[item] = types.count(item)
      end
    end

    trains_types
  end

  def depart_train(train)
    @trains.delete(train)
  end
end

# проверка
s1 = Station.new("mos")
s2 = Station.new("spb")
Station.all
