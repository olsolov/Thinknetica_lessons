# frozen_string_literal: true

module ProducerCompany
  attr_accessor :producer_company

  def print_company
    puts "Компания-производитель: #{@producer_company}"
  end
end
