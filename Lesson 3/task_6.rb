buy = {}
count = 0
total = 0

puts 'Введите "стоп" для выхода из программы'

loop do
  print 'Название товара: '
  product = gets.strip.downcase

  break if product == "стоп"

  print 'Цена за 1 товар: '
  price = gets.to_i

  print 'Кол-во товара: '
  quant = gets.to_i

  puts "------------------"

  buy[product] = {price => quant}
  count = price * quant

  total += count
end

puts buy

buy.each do |product, value|
  value.each do |k, v|
      puts "Стоимость товара \"#{product}\" = #{k * v} р."
  end
end

puts "Итоговая сумма покупок в \"корзине\": #{total}"
