require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'


@stations = []
@trains = []
@wagons = []
@routes = []

def show_stations
  @stations.each_with_index do |station, index|
      index +=1
      puts "#{index}. #{station}"
  end
end

def show_trains
  @trains.each_with_index do |train, index|
    index +=1
    puts "#{index}. #{train}"
  end
end

def show_routes
  @routes.each_with_index do |route, index|
    index +=1
    puts "#{index}. #{route}"
  end
end

def show_wagons
  @wagons.each_with_index do |wagon, index|
    index +=1
    puts "#{index}. #{wagon}"
  end
end

loop do
  puts "----------------------------"
  puts "Введите 1, если вы хотите создать станцию"
  puts "Введите 2, если вы хотите создать поезд"
  puts "Введите 3, если вы хотите создать вагон"
  puts "Введите 4, если вы хотите создать маршрут"
  puts "Введите 5, если вы хотите добавить станцию в маршрут или удалить"
  puts "Введите 6, если вы хотите назначить маршрут поезду"
  puts "Введите 7, если вы хотите добавить вагон поезду или отцепить"
  puts "Введите 8, если вы хотите переместить поезд вперед или назад по маршруту"
  puts "Введите 9, если вы хотите посмотреть список станций"
  puts "Введите 10, если вы хотите посмотреть список поездов на станции"
  puts "Введите 0, если хотите закончить программу"
  puts "----------------------------"

  choice = gets.strip

  case choice
  when "0"
    break

  #создать станцию  
  when "1"
    print "Введите название станции: "
    name = gets.strip.capitalize

    station = Station.new(name)
    @stations << station 
    puts @stations 

  # создать поезд
  when "2"
    print "Введите номер поезда: "
    number = gets.strip

    print "Введите 1, если вы хотите создать пассажирский поезд, 2 - если грузовой: "
    answer = gets.strip

    if answer == "1"
      train = PassengerTrain.new(number)
      @trains << train
      puts @trains
    elsif answer == "2"
      train = CargoTrain.new(number)
      @trains << train 
      puts @trains 
    else
      puts "Такого ответа нет"
    end

  # создать вагон
  when "3"
    print "Введите 1, если вы хотите создать пассажирский вагон, 2 - если грузовой: "
    answer = gets.strip

    if answer == "1"
      wagon = PassengerWagon.new
      puts "Вы создали пассажирский вагон"
      @wagons << wagon 
      puts @wagons # 
    elsif answer == "2"
      wagon = CargoWagon.new
      puts "Вы создали грузовой вагон"
      @wagons << wagon 
      puts @wagons 
    else
      puts "Такого ответа нет"
    end

  # создать маршрут
  when "4"
    puts "Введите порядковый номер первой станции в маршруте:"
    show_stations
    start_station_number = gets.to_i
    choice_station_start = @stations[start_station_number - 1]

    puts "Введите порядковый номер последней станции в маршруте:"
    show_stations
    finish_station_number = gets.to_i
    choice_station_finish = @stations[finish_station_number - 1]

    if choice_station_start == choice_station_finish
      puts "Начальная и конечная станции не могут совпадать, не удалось создать маршрут"
    else
      route = Route.new(choice_station_start, choice_station_finish)
    end
  
    @routes << route 
    @routes.each do |ro|
      puts ro 
    end

  # добавить станцию в маршрут или удалить
  when "5"
    print "Введите 1, если вы хотите добавить станцию в маршрут, 2 - если удалить: "
    answer = gets.strip

    puts "Введите порядковый номер маршрута: "
    show_routes
    route_number = gets.to_i

    choice_route = @routes[route_number - 1]

    puts "Введите порядковый номер станции: "
    show_stations
    
    station_number = gets.to_i

    choice_station = @stations[station_number - 1]

    if answer == "1"
      choice_route.add_middle(choice_station)
      puts choice_route.list 
    elsif answer == "2"
      choice_route.delete_middle(choice_station)
      puts choice_route.list 
    else
      puts "Такого ответа нет"
    end

  # назначить маршрут поезду
  when "6" 
    puts "Введите порядковый номер маршрута: "
    show_routes    
    route_number = gets.to_i

    puts "Введите порядковый номер поезда: "
    show_trains
    train_number = gets.to_i

    choice_route = @routes[route_number - 1]
    choice_train = @trains[train_number - 1]
    
    choice_train.add_route(choice_route)
  
  # добавить вагон поезду или отцепить 
  when "7" 
    print "Введите 1, если вы хотите добавить вагон, 2 - если отцепить: "
    answer = gets.strip

    puts "Введите порядковый номер вагона:"
    show_wagons
    wagon_number = gets.to_i

    puts "Введите порядковый номер поезда:" 
    show_trains
    train_number = gets.to_i

    choice_wagon = @wagons[wagon_number - 1]
    choice_train = @trains[train_number - 1]

    if answer == "1"     
      choice_train.accept_wagon(choice_wagon)
      puts choice_train.train_wagons 
    elsif answer == "2"
      choice_train.remove_wagon(choice_wagon)
      puts choice_train.train_wagons 
    else
      puts "Такого ответа нет"
    end

  # переместить поезд вперед или назад по маршруту
  when "8"
    
    print "Введите 1, если вы хотите переместить поезд вперед по маршруту, 2 - если назад: "
    answer = gets.strip

    puts "Введите порядковый номер поезда: "
    show_trains
    train_number = gets.to_i

    choice_train = @trains[train_number - 1]
    puts choice_train.current_station

    if answer == "1"         
      choice_train.move_to_next_station
    elsif answer == "2" 
      choice_train.move_to_previous_station
    else
      puts "Такого ответа нет"
    end
    puts choice_train.current_station

  # посмотреть список станций
  when "9" 
    show_stations

  # посмотреть список поездов на станции
  when "10"
    puts "Введите порядковый номер станции: "
    show_stations
    station_number = gets.to_i

    choice_station = @stations[station_number - 1]

    @trains.each do |train|
      if train.current_station == choice_station
        puts train
      end
    end

  else
     puts "Такого ответа нет"
  end
end
