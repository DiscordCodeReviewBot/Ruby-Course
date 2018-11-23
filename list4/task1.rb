class Expression

  def to_s
  end
end

class Constant < Expression

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def calculate
    @value
  end
end


class Variable < Expression

  def initialize(name)
    @name = name
  end
end

class Addition < Expression

  def initialize(first, second)
    @first = first
    @second = second
  end

  def calculate
    @first.calculate + @second.calculate
  end

  def to_s
    @first.calculate + @second.calculate
  end
end

class Subtraction < Expression

  def initialize(first, second)
    @first = first
    @second = second
  end

  def calculate
    @first.calculate - @second.calculate
  end
end

class Division < Expression

  def initialize(first, second)
    @first = first
    @second = second
  end

  def calculate
    @first.calculate / @second.calculate
  end
end

class Multiplication < Expression

  def initialize(first, second)
    @first = first
    @second = second
  end

  def calculate
    @first.calculate * @second.calculate
  end
  def to_s
    @first.calculate * @second.calculate
  end
end

puts Multiplication.new(Addition.new(Constant.new(5), Constant.new(6)),Subtraction.new(Constant.new(6), Constant.new(5))).to_s
puts Division.new(Addition.new(Constant.new(5), Constant.new(6)),Subtraction.new(Constant.new(6), Constant.new(5))).to_s
puts Subtraction.new(Addition.new(Constant.new(5), Constant.new(6)),Subtraction.new(Constant.new(6), Constant.new(5))).to_s