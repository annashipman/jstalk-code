numbersarray = []
100.times do 
numbers = rand(100)
str = numbers.to_s + ","
numbersarray << str
end

puts numbersarray
