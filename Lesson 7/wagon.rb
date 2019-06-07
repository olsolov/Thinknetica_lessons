require_relative 'producer_company'

class Wagon
  include ProducerCompany

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected
  def validate!
    raise "Такого типа нет" unless @type == :passenger || @type == :cargo
  end
end
