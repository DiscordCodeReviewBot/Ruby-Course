require 'prime'
def rozklad(n)
  m = n
  tab = []
  while m>1
    (1..Math.sqrt(n)).select {|i| i if i.prime?}.reverse_each do |elem|
      if n % elem == 0
        counter = 0
        while m % elem == 0
          m = m / elem
          counter += 1
        end
        tab.push([elem,counter])
      end
    end
  end
  return(tab.sort)
end

def amicable_pairsv1(n)
  def sum_factors(number)
    temp = []
    (2...Math.sqrt(number)).each do |i|
      if number % i == 0
        temp.push(i, number/i)
      end
    end
    return temp.uniq.sum+1
  end
  result = []
  (2..n).each do |i|
    j = sum_factors(i)
    if sum_factors(j) == i and j!=i
      result.push([i,j].sort)
    end
  end
  result
end


def amicable_pairsv2(n)
  def sum_factors(number)
    temp = []
    if number%2==0
      (2...Math.sqrt(number)).each do |i|
        if number % i == 0
          temp.push(i, number/i)
        end
      end
    else
      (3...Math.sqrt(number)).step(2).each do |i|
        if number % i == 0
          temp.push(i, number/i)
        end
      end
    end

    return temp.uniq.sum+1
  end
  result = []
  (2..n).each do |i|
    j = sum_factors(i)
    if sum_factors(j) == i and j!=i
      result.push([i,j].sort)
    end
  end
  result
end

print(rozklad(756))
puts
start = Time.now
print(amicable_pairsv2(4000000))
finish = Time.now - start
print ("\nTime: %f" % finish)
puts
start = Time.now
print(amicable_pairsv1(4000000))
finish = Time.now - start
print ("\nTime without odd numbers improvment: %f" % finish)
puts
