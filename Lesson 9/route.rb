# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :list, :start, :finish
  validate :start, :type, Station
  validate :finish, :type, Station

  def initialize(start, finish)
    @start = start
    @finish = finish
    validate!
    @list = [start, finish]
    register_instance
  end

  def add_middle(station)
    @list.insert(-2, station) unless @list.include?(station)
  end

  def delete_middle(station)
    @list.delete(station) if (@list[0] != station) && (@list[-1] != station)
  end
end
