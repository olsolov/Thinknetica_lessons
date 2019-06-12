require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :list, :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
    validate!
    @list = [start, finish]
    self.register_instance
  end  

  def valid?
    validate!
  rescue
    false
  end

  def add_middle(station)
    @list.insert(-2, station) unless @list.include?(station)
  end

  def delete_middle(station)
    @list.delete(station) if (@list[0] != station) && (@list[-1] != station) 
  end

  protected
  def validate!
    raise 'Начальная станция не может быть пустой' if @start.nil?
    raise 'Конечная станция не может быть пустой' if @finish.nil?
  end
end
