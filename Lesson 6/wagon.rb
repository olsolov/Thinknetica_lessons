require_relative 'producer_company'

class Wagon
  include ProducerCompany

  attr_reader :type
end