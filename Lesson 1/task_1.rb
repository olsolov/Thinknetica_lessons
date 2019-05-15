print "Введите ваше имя: "
name = gets.strip.capitalize

print "Введите ваш рост в сантиметрах: "
person_height = gets.to_i

ideal_weight = person_height - 110

if ideal_weight <= 0
	puts "#{name}, ваш вес уже оптимальный."
	else
		puts "#{name}, ваш идеальный вес #{ideal_weight} кг."
end


