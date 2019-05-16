print "Введите 1-ю сторону треугольника: "
a = gets.to_f

print "Введите 2-ю сторону треугольника: "
b = gets.to_f

print "Введите 3-ю сторону треугольника: "
c = gets.to_f

a, b, max = [a, b, c].sort

if a < max && b < max 
  square_sides = a ** 2 + b ** 2
elsif a < max && c < max 
  square_sides = a ** 2 + c ** 2	
else 
  square_sides = b ** 2 + c ** 2	
end

hypotenuse = max

square_hypotenuse = hypotenuse ** 2

if square_hypotenuse == square_sides
  puts "Треугольник прямоугольный"
elsif ( square_hypotenuse == square_sides ) && ( a == b || b == c || a == c )
  puts "Треугольник прямоугольный и равнобедеренный"
elsif (a == b || b == c || a == c) && (a == b && a == c)
  puts "Треугольник равнобедренный и равносторонний, но не прямоугольный"
else 
  puts "Треугольник не прямоугольный"
end
