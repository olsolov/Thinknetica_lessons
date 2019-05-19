fibo = [0, 1]

loop do
  fibo_next = fibo[-1] + fibo[-2]

  break if fibo_next > 100 

  fibo.push(fibo_next)
end

puts fibo
