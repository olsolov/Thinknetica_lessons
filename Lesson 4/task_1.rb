class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def show_trains
    @trains.each { |train| puts train}
  end

  def show_type
    count_pass = 0
    count_cargo = 0

    @trains.each do |train|
      if train[1] == "pass"
        count_pass +=1
      else
        count_cargo +=1
      end
    end

    puts "Quantity of passenger trains is #{count_pass}"
    puts "Quantity of cargo trains is #{count_cargo}"
  end

  def depart_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :route_list

  def initialize(start, finish)
    @route_list = [start, finish]
  end

  def add_middle(station)
    @route_list.insert(-2, station)  
  end

  def delete_middle(station)
    @route_list.delete(station)  
  end

  def show_stations 
    @route_list.each { |stations| puts stations }
  end
end

class Train
  def initialize(number, type, wagons)
    @train = [number, type, wagons]
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def speed=(speed)
    @speed = speed
  end

  def speed
    @speed
  end

  def stop
    self.speed = 0
  end

  def wagons
    @wagons
  end

  def add_wagon
    @wagons += 1 if @speed == 0
  end

  def remote_wagon
    @wagons -= 1 if @speed == 0
  end

  def add_route(route)
    @train_route = route.route_list
    @current_station = 0 unless @train_route.nil?
    @train_route
  end

  def next
    @current_station +=1
  end

  def prev
    @current_station -=1
  end

  def show_route_stations
    puts "Previous station is #{@train_route[@current_station - 1]}"
    puts "Current station is #{@train_route[@current_station]}"
    puts "The next station is #{@train_route[@current_station + 1]}"
  end
end
