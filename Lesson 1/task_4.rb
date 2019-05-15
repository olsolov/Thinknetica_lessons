print "Введите коэффициент a: "
a = gets.to_i

print "Введите коэффициент b: "
b = gets.to_i

print "Введите коэффициент c: "
c = gets.to_i

discriminant = b ** 2 - 4 * a * c

puts "D = #{discriminant}" 

square_root = Math.sqrt(discriminant)

if 
	discriminant < 0	
		puts "Корней нет"
elsif 	
	discriminant > 0
	x1 = (- b + square_root)/(2 * a)
	x2 = (- b - square_root)/(2 * a) 
	puts "x1 = #{x1}"
	puts "x2 = #{x2}"
else
	x = - b/(2*a)
	puts "x = #{x}"	
end
