fibo = [0, 1]

i = 0

loop do
  fibo_next = fibo[i] + fibo[i+1]

  i += 1

  break if fibo_next > 100 

  fibo.push(fibo_next)
end

puts fibo
