require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'

class Main
  def initialize
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

  def show_stations
    Station.all.each do |station|
      puts station.name
    end
  end

  def show_trains
    Train.all.each do |train|
      puts "№ поезда: #{train.number}, тип: #{train.type}"
    end
  end

  def show_routes
    @routes.each_with_index do |route, index|
      index +=1
      puts "#{index}. Маршрут: #{route.list[0].name} - #{route.list[-1].name}"
    end
  end

  def show_wagons
    @wagons.each_with_index do |wagon, index|
      index +=1
      puts "#{index}. Вагон: #{wagon.type}"
    end
  end

  def create_station

    print "Введите название станции: "
    name = gets.strip.capitalize

    station = Station.new(name)
    puts "Вы создали станцию: #{station.name}"
    rescue RuntimeError => e
      puts e.message
  end  

  def create_train
    print "Введите номер поезда: "
    number = gets.strip

    print "Введите 1, если вы хотите создать пассажирский поезд, 2 - если грузовой: "
    answer = gets.to_i

    puts "Такого типа поезда нет" unless answer == 1 || answer == 2 

    train = PassengerTrain.new(number) if answer == 1

    train = CargoTrain.new(number) if answer == 2

    puts "Вы создали поезд: № #{train.number}, тип: #{train.type}"

    rescue RuntimeError => e
      puts e.message
      retry
  end

  def create_wagon
    print "Введите тип вагона, который вы хотите создать(passenger/cargo): "
    type = gets.strip.downcase.to_sym

    wagon = Wagon.new(type)
    @wagons << wagon
    puts "Вы создали вагон, тип: #{wagon.type}" 

    rescue RuntimeError => e
    puts e.message
  end

  def create_route
    puts "Введите название первой станции в маршруте:"
    show_stations
    start_station = gets.strip.capitalize
    choice_start_station = Station.find(start_station)

    puts "Введите название последней станции в маршруте:"
    show_stations
    finish_station = gets.strip.capitalize
    choice_finish_station = Station.find(finish_station)

    if choice_start_station == choice_finish_station
      puts "Начальная и конечная станции не могут совпадать, не удалось создать маршрут"
    else
      route = Route.new(choice_start_station, choice_finish_station)
      @routes << route
      puts "Вы создали маршрут: #{route.list[0].name} - #{route.list[1].name}"
    end

    rescue RuntimeError => e
      puts e.message
  end

  def add_or_delete_station_in_route

    puts "Пока не создано ни одного маршрута" if Route.instances == 0

    print "Введите 1, если вы хотите добавить станцию в маршрут, 2 - если удалить: "
    answer = gets.to_i

    puts "Введите порядковый номер маршрута: "
    show_routes
    route_number = gets.to_i

    choice_route = @routes[route_number - 1]

    puts "Введите имя станции: "
    show_stations
    
    choice_name = gets.strip.capitalize

    choice_station = Station.find(choice_name)

    puts "Такого ответа нет" unless answer == 1 || answer == 2 

    if answer == 1
      choice_route.add_middle(choice_station)
    elsif answer == 2
      choice_route.delete_middle(choice_station)
    end

    puts "Список станций в маршруте:"
    choice_route.list.each_with_index do |station, index|
      index +=1
      puts "#{index}. #{station.name}"
    end

    rescue RuntimeError => e
      puts e.message
  end

  def assign_route_to_train
    puts "Введите порядковый номер маршрута: "
    show_routes
    route_number = gets.to_i

    puts "Введите номер поезда: "
    show_trains
    train_number = gets.to_i

    choice_route = @routes[route_number - 1]
    choice_train = Train.find(train_number)
    
    choice_train.add_route(choice_route)

    puts "Вы назначили маршрут #{choice_route.list[0].name} - #{choice_route.list[-1].name} поезду № #{choice_train.number}"
  end

  def add_or_remove_wagon_by_train
    print "Введите 1, если вы хотите добавить вагон, 2 - если отцепить: "
    answer = gets.to_i

    puts "Введите порядковый номер вагона:"
    show_wagons
    wagon_number = gets.to_i

    puts "Введите номер поезда:"
    show_trains
    train_number = gets.to_i

    choice_wagon = @wagons[wagon_number - 1]
    choice_train = Train.find(train_number)
    
    if answer == 1
      choice_train.accept_wagon(choice_wagon)
      puts "Вы прицепили вагон к поезду № #{choice_train.number}"
    elsif answer == 2
      choice_train.remove_wagon(choice_wagon)
      puts "Вы отцепили вагон от поезда № #{choice_train.number}"
    else
      puts "Такого ответа нет"
    end
    # проверка 
    # p choice_train.train_wagons
  end

  def move_train_next_or_previous_station
    print "Введите 1, если вы хотите переместить поезд вперед по маршруту, 2 - если назад: "
    answer = gets.to_i

    puts "Введите номер поезда:"
    show_trains
    train_number = gets.to_i

    choice_train = Train.find(train_number)

    if answer == 1
      choice_train.move_to_next_station
    elsif answer == 2
      choice_train.move_to_previous_station
    else
      puts "Такого ответа нет"
    end
  end

  def show_trains_by_station
    puts "Введите имя станции:"
    show_stations
    station_name = gets.strip.capitalize

    choice_station = Station.find(station_name)
    Train.all.each do |train|
      if train.current_station.name == choice_station.name
        puts "На станции #{choice_station.name} находится: поезд № #{train.number}"
      end
    end
  end
end

new_use = Main.new
new_use.start
