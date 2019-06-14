# frozen_string_literal: true

require_relative 'producer_company'
require_relative 'instance_counter'

class Train
  include ProducerCompany
  include InstanceCounter

  @@trains = {}

  attr_reader :number, :speed, :train_wagons, :current, :route

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-*[a-f0-9]{2}$/i.freeze

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @train_wagons = []
    @@trains[number] = self
    register_instance
  end

  def wagons_by_trains
    @train_wagons.each do |wagon|
      yield(wagon)
    end
  end

  def valid?
    validate!
  rescue StandardError
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
    @speed = 0 if @speed.negative?
  end

  def stop
    @speed = 0
  end

  def add_route(route)
    @route = route
    @current = 0 unless @route.nil?
    current_station.accept_train(self)
  end

  def remove_wagon(wagon)
    @train_wagons.delete(wagon) if @speed.zero?
  end

  def current_station
    @route.list[@current]
  end

  def move_to_previous_station
    return unless previous_station

    previous_station.accept_train(self)
    current_station.depart_train(self)
    @current -= 1
  end

  def move_to_next_station
    return unless next_station

    next_station.accept_train(self)
    current_station.depart_train(self)
    @current += 1
  end

  protected

  def validate!
    raise 'Номер поезда не соответствует формату' if @number !~ NUMBER_FORMAT
  end

  def previous_station
    @route.list[@current - 1] if @current != 0
  end

  def next_station
    @route.list[@current + 1]
  end
end
