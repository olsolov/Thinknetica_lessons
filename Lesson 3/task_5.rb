select_month = []
sum = 0

print 'Введите число: '
day = gets.to_i

print 'Введите номер месяца(1 - 12): '
month = gets.to_i

print 'Введите год: '
year = gets.to_i

month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

leap_year = (year%4 == 0) && (year%100 != 0) || (year%400 == 0)

month_days[1] = 29 if leap_year  

if month == 1 
  date_number = day
else
  select_month = month_days.take(month - 1)
  select_month.each { |days| sum += days }
  date_number = day + sum
end 

puts "Порядковый номер даты: #{date_number}"
