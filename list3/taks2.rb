require 'prime'

def prime_numbers(n)
  return Prime.take_while {|p| p < 10 }
end

print(prime_numbers(10))

def perfect_numbers(n)
  return (2...n).select {|number| number == (1...number).select{|i| number % i == 0}.inject(0){|sum,x| sum + x}}
end

print(perfect_numbers(1000))