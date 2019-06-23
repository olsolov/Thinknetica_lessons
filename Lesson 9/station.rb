# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^[А-Я]{1}[а-я]{3}[а-я]*/.freeze

  @@stations = {}

  attr_reader :name, :trains
  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations[name] = self
    register_instance
  end

  def trains_by_station
    @trains.each do |train|
      yield(train)
    end
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
    types = []
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
