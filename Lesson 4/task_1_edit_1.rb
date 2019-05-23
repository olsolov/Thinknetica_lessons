class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def show_trains
    @trains.each { |train| train}
  end

  def show_type
    count_pass = 0
    count_cargo = 0

    @trains.each do |train|
      count_pass +=1 if train.type["pass"]
      count_pass +=1 if train.type["cargo"]
      
      "Quantity of passenger trains: #{count_pass}"
      "Quantity of cargo trains: #{count_cargo}"
    end
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
    @list.delete(station)  
  end

  def show_stations 
    @list.each { |stations| stations }
  end
end

class Train
  attr_reader :wagons, :speed 

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

  def remote_wagon
    @wagons -= 1 if @speed == 0 && @wagons > 0
    "Stop to unhook the wagon" if @speed > 0
  end

  def add_route(route)
    @route = route
    @current = 0 unless @route.nil?
  end

  def next_station
    @current +=1 if @route.list.length != @current
    @current
  end

  def prev_station
    @current -=1 if @current != 0
    @current
  end

  def show_route
    @prev_st = @route.list[@current - 1]
    @cur_st = @route.list[@current]
    @next_st = @route.list[@current + 1]
  end
end
