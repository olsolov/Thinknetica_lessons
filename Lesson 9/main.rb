# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

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
      when '0'
        break
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_wagon
      when '4'
        create_route
      when '5'
        add_or_delete_station_in_route
      when '6'
        assign_route_to_train
      when '7'
        add_or_remove_wagon_by_train
      when '8'
        move_next_or_previous_station
      when '9'
        show_stations_info
      when '10'
        show_trains_by_station
      when '11'
        take_seet_by_wagon
      when '12'
        take_volume_by_wagon
      else
        puts 'Такого ответа нет'
      end
    end
  end

  def seed
    station1 = Station.new('Dzerzhinsk')
    station2 = Station.new('Moscow')
    station3 = Station.new('Saint Petersburg')

    train1 = PassengerTrain.new('11111')
    train2 = CargoTrain.new('22222')

    wagon1 = PassengerWagon.new(40)
    wagon2 = PassengerWagon.new(50)
    wagon3 = CargoWagon.new(100)
    wagon4 = CargoWagon.new(120)
    @wagons << wagon1
    @wagons << wagon2
    @wagons << wagon3
    @wagons << wagon4

    route1 = Route.new(station1, station3)
    @routes << route1

    train1.add_route(route1)

    train1.accept_wagon(wagon1)
    train1.accept_wagon(wagon2)
    train2.accept_wagon(wagon3)
    train2.accept_wagon(wagon4)
  end

  private

  def menu
    puts '----------------------------'
    puts 'Введите цифру для выбора действия:'
    puts '1, если вы хотите создать станцию'
    puts '2, если вы хотите создать поезд'
    puts '3, если вы хотите создать вагон'
    puts '4, если вы хотите создать маршрут'
    puts '5, если вы хотите добавить станцию в маршрут или удалить'
    puts '6, если вы хотите назначить маршрут поезду'
    puts '7, если вы хотите добавить вагон поезду или отцепить'
    puts '8, если вы хотите переместить поезд вперед/назад по маршруту'
    puts '9, если вы хотите посмотреть список станций'
    puts '10, если вы хотите посмотреть список поездов на станции'
    puts '11, если вы хотите занять место в вагоне'
    puts '12, если вы хотите занять объем в вагоне'
    puts '0, если хотите закончить программу'
    puts '----------------------------'
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
      puts "#{index + 1}. Маршрут: #{route.list.first.name} - #{route.list.last.name}"
    end
  end

  def show_wagons
    @wagons.each_with_index do |wagon, index|
      puts "#{index + 1}. Вагон: #{wagon.type}"
    end
  end

  def create_station
    print 'Введите название станции: '
    name = gets.strip.capitalize

    station = Station.new(name)

    puts "Вы создали станцию: #{station.name}"
  rescue RuntimeError => e
    puts e.message
  end

  def create_train
    print 'Введите номер поезда: '
    number = gets.strip

    print 'Введите 1, если вы хотите создать пассажирский поезд, 2 - если грузовой: '
    answer = gets.to_i

    answer_choices = [1, 2]

    puts 'Такого типа поезда нет' unless answer_choices.include?(answer)

    train = PassengerTrain.new(number) if answer == 1

    train = CargoTrain.new(number) if answer == 2

    puts "Вы создали поезд: № #{train.number}, тип: #{train.type}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_wagon
    print 'Введите тип вагона, который вы хотите создать(passenger/cargo): '
    type = gets.strip.downcase.to_sym

    if type == :passenger
      print 'Введите количество мест в вагоне: '
      total_seats = gets.to_i
      wagon = PassengerWagon.new(total_seats)
      puts "Создан вагон, тип: #{wagon.type}, кол-во мест: #{total_seats}"
    elsif type == :cargo
      print 'Введите общий объем вагона: '
      total_volume = gets.to_i
      wagon = CargoWagon.new(total_volume)
      puts "Вы создали вагон, тип: #{wagon.type}, V = #{total_volume}"
    else
      puts 'Такого типа вагонов нет, вагон не создан'
    end

    @wagons << wagon
  rescue RuntimeError => e
    puts e.message
  end

  def create_route
    puts 'Введите название первой станции в маршруте:'
    show_stations
    start_station = gets.strip.capitalize
    choice_start_station = Station.find(start_station)

    puts 'Введите название последней станции в маршруте:'
    show_stations
    finish_station = gets.strip.capitalize
    choice_finish_station = Station.find(finish_station)

    if choice_start_station == choice_finish_station
      puts 'Начальная и конечная станции не могут совпадать, маршрут не создан'
    else
      route = Route.new(choice_start_station, choice_finish_station)
      @routes << route
      puts "Вы создали маршрут: #{route.list.first.name} - #{route.list.last.name}"
    end
  rescue RuntimeError => e
    puts e.message
  end

  def add_or_delete_station_in_route
    puts 'Пока не создано ни одного маршрута' if Route.instances.zero?

    print 'Введите 1, если вы хотите добавить станцию в маршрут, 2 - если удалить: '
    answer = gets.to_i

    puts 'Введите порядковый номер маршрута: '
    show_routes
    route_number = gets.to_i

    choice_route = @routes[route_number - 1]

    puts 'Введите название станции: '
    show_stations

    choice_name = gets.strip.capitalize

    choice_station = Station.find(choice_name)

    answer_choices = [1, 2]

    puts 'Такого ответа нет' unless answer_choices.include?(answer)

    if answer == 1
      choice_route.add_middle(choice_station)
    elsif answer == 2
      choice_route.delete_middle(choice_station)
    end

    puts 'Список станций в маршруте:'
    choice_route.list.each_with_index do |station, index|
      puts "#{index + 1}. #{station.name}"
    end
  rescue RuntimeError => e
    puts e.message
  end

  def assign_route_to_train
    puts 'Введите порядковый номер маршрута: '
    show_routes
    route_number = gets.to_i

    puts 'Введите номер поезда: '
    show_trains
    train_number = gets.strip

    choice_route = @routes[route_number - 1]
    choice_train = Train.find(train_number)

    choice_train.add_route(choice_route)

    puts "Вы назначили маршрут #{choice_route.list.first.name} - #{choice_route.list.last.name} поезду № #{choice_train.number}"
    puts "Текущая станция #{choice_train.current_station.name}"
  end

  def add_or_remove_wagon_by_train
    print 'Введите 1, если вы хотите добавить вагон, 2 - если отцепить: '
    answer = gets.to_i

    puts 'Введите порядковый номер вагона:'
    show_wagons
    wagon_number = gets.to_i

    puts 'Введите номер поезда:'
    show_trains
    train_number = gets.strip

    choice_wagon = @wagons[wagon_number - 1]
    choice_train = Train.find(train_number)

    if answer == 1
      choice_train.accept_wagon(choice_wagon)
      puts "Вы прицепили вагон к поезду № #{choice_train.number}"
    elsif answer == 2
      choice_train.remove_wagon(choice_wagon)
      puts "Вы отцепили вагон от поезда № #{choice_train.number}"
    else
      puts 'Такого ответа нет'
    end
  end

  def move_next_or_previous_station
    print 'Введите 1, если вы хотите переместить поезд вперед по маршруту, 2 - если назад: '

    answer = gets.to_i

    puts 'Введите номер поезда:'
    show_trains
    train_number = gets.strip

    choice_train = Train.find(train_number)

    if answer == 1
      choice_train.move_to_next_station
    elsif answer == 2
      choice_train.move_to_previous_station
    else
      puts 'Такого ответа нет'
    end
    puts "Поезд #{choice_train.number} находится на станции #{choice_train.current_station.name}"
  end

  def show_stations_info
    Station.all.each do |station|
      if station.trains.size.zero?
        puts "На станции #{station.name} нет поездов"
      else
        puts "На станции #{station.name} находятся поезда:"
        station.trains_by_station do |train|
          puts "Поезд № #{train.number}, тип: #{train.type}, кол-во вагонов: #{train.train_wagons.count}"
        end
      end
    end
  end

  def show_trains_by_station
    puts 'Введите название станции:'
    show_stations
    station_name = gets.strip.capitalize

    choice_station = Station.find(station_name)

    choice_station.trains.each do |train|
      puts "На станции #{choice_station.name} находится поезд #{train.number}:"
      if train.type == :passenger
        train.wagons_by_trains do |wagon|
          puts "№ вагона: #{rand(10..99)}, тип: #{wagon.type},
кол-во свободных/занятых мест: #{wagon.vacant_seats}/#{wagon.busy_seats}"
        end
      elsif train.type == :cargo
        train.wagons_by_trains do |wagon|
          puts "№ вагона: #{rand(10..99)}, тип: #{wagon.type},
кол-во свободного/занятого объема: #{wagon.available_volume}/#{wagon.busy_volume}"
        end
      end
    end
  end

  def take_seet_by_wagon
    puts 'Введите номер поезда, в котором вы хотите занять место: '
    show_trains
    train_number = gets.strip
    choice_train = Train.find(train_number)
    if choice_train.type == :passenger
      puts 'Введите порядковый номер вагона, в котором вы хотите занять место: '
      choice_train.train_wagons.each_with_index do |wagon, index|
        puts "#{index + 1}. Вагон: #{wagon.type}"
      end

      answer = gets.to_i
      choice_wagon = choice_train.train_wagons[answer - 1]
      choice_wagon.take_seat
      puts "Вы заняли место в поезде № #{choice_train.number}, в #{answer} вагоне"
    else
      puts 'Вы не можете занять место в поезде, т.к. поезд не пассажирский'
    end
  end

  def take_volume_by_wagon
    puts 'Введите номер поезда, в котором вы хотите занять объем: '
    show_trains
    train_number = gets.strip
    choice_train = Train.find(train_number)
    if choice_train.type == :cargo
      puts 'Введите порядковый № вагона, в котором вы хотите занять объем:'
      choice_train.train_wagons.each_with_index do |wagon, index|
        puts "#{index + 1}. Вагон: #{wagon.type}"
      end
      answer = gets.to_i
      choice_wagon = choice_train.train_wagons[answer - 1]

      print 'Введите количество кубов, которые вы хотите занять в вагоне: '
      volume = gets.to_i

      choice_wagon.take_volume(volume)
      puts "Вы заняли #{volume} кубов
      в поезде № #{choice_train.number}, в #{answer} вагоне"
    else
      puts 'Вы не можете занять объем в вагоне поезда, т.к. поезд не грузовой'
    end
  end
end

new_use = Main.new
new_use.seed
new_use.start
