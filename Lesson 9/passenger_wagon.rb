# frozen_string_literal: true

require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :type, :busy_seats

  def initialize(total_seats)
    @total_seats = total_seats
    @type = :passenger
    @busy_seats = 0
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def take_seat
    @busy_seats += 1 unless @busy_seats == @total_seats
  end

  def vacant_seats
    @total_seats - @busy_seats
  end

  protected

  def validate!
    raise 'В вагоне должны быть места для пассажиров' unless @total_seats.positive?
  end
end
