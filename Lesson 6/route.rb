require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :list

  def initialize(start, finish)
    @list = [start, finish]
    self.register_instance
  end

  def add_middle(station)
    @list.insert(-2, station) unless @list.include?(station)
  end

  def delete_middle(station)
    @list.delete(station) if (@list[0] != station) && (@list[-1] != station) 
  end
end
