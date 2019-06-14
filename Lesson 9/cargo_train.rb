# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :cargo
  end

  def accept_wagon(wagon)
    return unless @speed.zero? && wagon.type == :cargo

    @train_wagons << wagon unless @train_wagons.include?(wagon)
  end
end
