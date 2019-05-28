class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_types
    types =[]
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
