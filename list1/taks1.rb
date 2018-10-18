require 'prime'


def podzielniki(n)
  primes = Prime.each(n/2).to_a
  primes.each do |i|
    if n%i == 0
      puts i
    end
  end
end


def pascal(number_of_rows)
  ret = Array.new
  (1..number_of_rows).each do |row|
    if row == 1
      ret.push([1])
    elsif row == 2
      ret.push([1,1])
    elsif row == 3
      ret.push([1,2,1])
    else
      temp = Array.new
      temp.push(1)
      (1..row-2).each do |elem|
        temp.push(ret[row-2][elem-1]+ret[row-2][elem])
      end
      temp.push(1)
      ret.push(temp)
    end
  end
  ret.each do |list|
    list.each do |elem|
      print(elem, " ")
    end
    puts
  end
end





podzielniki(1025)
puts
podzielniki(100055)
puts
podzielniki(53251)
puts

pascal(3)
puts
pascal(10)










# def print_pascal(n)
#   (1..n).each do |i|
#     pascal(i).each do |j|
#       print(j, " ")
#     end
#     puts
#   end
# end


# print_pascal(20)