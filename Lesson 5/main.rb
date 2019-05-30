require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Main
  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def start
    loop do
      menu

      choice = gets.strip

      case choice
      when "0"
        break
      when "1"
        create_station
      when "2"
        create_train
      when "3"
        create_wagon
      when "4"
        create_route
      when "5"
        add_or_delete_station_in_route
      when "6"
        assign_route_to_train
      when "7"
        add_or_remove_wagon_by_train
      when "8"
        move_train_next_or_previous_station
      when "9"
        show_stations
      when "10"
        show_trains_by_station
      else
        puts "Такого ответа нет"
      end
    end
  end

  private
  
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

  def create_station
    print "Введите название станции: "
    name = gets.strip.capitalize

    station = Station.new(name)
    @stations << station
    puts @stations
  end

  def menu
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
  end

  def create_train
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
  end

  def create_wagon
    print "Введите 1, если вы хотите создать пассажирский вагон, 2 - если грузовой: "
    answer = gets.strip

    if answer == "1"
      wagon = PassengerWagon.new
      puts "Вы создали пассажирский вагон"
      @wagons << wagon
      puts @wagons 
    elsif answer == "2"
      wagon = CargoWagon.new
      puts "Вы создали грузовой вагон"
      @wagons << wagon
      puts @wagons
    else
      puts "Такого ответа нет"
    end
  end

  def create_route
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
    @routes.each do |route|
      puts route
    end
  end

  def add_or_delete_station_in_route
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
  end

  def assign_route_to_train
    puts "Введите порядковый номер маршрута: "
    show_routes
    route_number = gets.to_i

    puts "Введите порядковый номер поезда: "
    show_trains
    train_number = gets.to_i

    choice_route = @routes[route_number - 1]
    choice_train = @trains[train_number - 1]
    
    choice_train.add_route(choice_route)
  end

  def add_or_remove_wagon_by_train
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
  end

  def move_train_next_or_previous_station
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
  end

  def show_trains_by_station
    puts "Введите порядковый номер станции: "
    show_stations
    station_number = gets.to_i

    choice_station = @stations[station_number - 1]

    @trains.each do |train|
      if train.current_station == choice_station
        puts train
      end
    end
  end
end

new_use = Main.new
new_use.start
