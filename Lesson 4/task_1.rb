class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def show_type
    count_type_trains = {}
    count_passenger = 0
    count_cargo = 0

    @trains.each do |train|
      count_passenger +=1 if train.type == "passenger"
      count_cargo +=1 if train.type == "cargo"
    end

    count_type_trains["passenger"] = count_passenger
    count_type_trains["cargo"] = count_cargo
    count_type_trains
  end

  def depart_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :list

  def initialize(start, finish)
    @list = [start, finish]
  end

  def add_middle(station)
    @list.insert(-2, station)  
  end

  def delete_middle(station)
    @list.delete(station) if (@list[0] != station) && (@list[-1] != station) 
  end
end

class Train
  attr_reader :type, :wagons, :speed

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def speed=(speed)
    @speed = speed
    @speed = 0 if @speed < 0 
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons += 1 if @speed == 0
  end

  def remove_wagon
    @wagons -= 1 if @speed == 0 && @wagons > 0
  end

  def add_route(route)
    @route = route
    @current = 0 unless @route.nil?
  end

  def current_station
    @route.list[@current]
  end

  def previous_station
    @route.list[@current - 1] if @current != 0
  end

  def next_station
    @route.list[@current + 1]
  end

  def move_to_previous_station
    @current -=1 if @current != 0
  end

  def move_to_next_station
    @current +=1 if @route.list.last != @route.list[@current]
  end
end
