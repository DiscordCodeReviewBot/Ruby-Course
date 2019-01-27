require './getData'



class GraphCreator

  def initialize
    @date_1 = nil
    @date_2 = nil
    @date_1_day = nil
    @date_1_month = nil
    @date_1_year = nil
    @date_2_day = nil
    @date_2_month = nil
    @date_2_year = nil
  end

  def set_date(date_1, date_2)
    @date_1 = date_1
    @date_2 = date_2
  end

  def parse_date

  end

  def create_graph(currency)

  end

end




















def serialize(data)
  File.open("data.txt","wb") do |file|
    Marshal.dump(data,file)
  end
end