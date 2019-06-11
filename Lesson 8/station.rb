require_relative 'instance_counter'

class Station
  include InstanceCounter

  @@stations = {}

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations[name] = self
    self.register_instance
  end

  def yield_method(items)
    items.each do |item|
      yield(item)
    end
  end

  # def yield_trains_by_station
  #   @trains.each do |train|
  #     yield(train)
  #   end
  # end

  def valid?
    validate!
  rescue
    false
  end

  def self.all
    @@stations.values
  end

  def self.find(find_name)
    @@stations[find_name]
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

  protected
  def validate!
    raise "Название станции не может быть пустым" if @name.length == 0
    raise "Название станции не может быть менее 4 букв" if @name.length < 4
  end
end
