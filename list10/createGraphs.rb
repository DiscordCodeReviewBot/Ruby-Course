require './getData'
require 'selenium-webdriver'
require './homePage'
require 'googlecharts'
require "gchart"

class GraphCreator

  # Initializes nill values to update later
  def initialize
    @get_data_object = nil
    @currency_data = nil
    @currency_data_parsed = []

    @date_1 = nil
    @date_2 = nil
    @date_1_day = nil
    @date_1_month = nil
    @date_1_year = nil
    @date_2_day = nil
    @date_2_month = nil
    @date_2_year = nil

    @data_array = nil
  end

  # Set date instance variables taken from entry labels
  # Params:
  # +date_1+:: Begin date
  # +date_2+:: End date
  def set_date(date_1, date_2)
    @date_1 = date_1
    @date_2 = date_2
  end

  # Splits date to year month day
  def parse_date
    @date_1_day = @date_1[0,2]
    @date_1_month = @date_1[3] + @date_1[4]
    @date_1_year = @date_1[6]+@date_1[7]+@date_1[8]+@date_1[9]

    @date_2_day = @date_2[0,2]
    @date_2_month = @date_2[3] + @date_2[4]
    @date_2_year = @date_2[6]+@date_2[7]+@date_2[8]+@date_2[9]
  end

  # Retreives data from webpage
  # Params:
  # +currency+:: PLN/EUR - currency used to drwa charts
  # +start_year+:: start year for date range
  # +start_month+:: start month for date range
  # +start_day+:: start day for date range
  # +end_year+:: end year for date range
  # +end_month+:: end month for date range
  # +end_day+:: end day for date range
  def get_data(currency, start_year, start_month, start_day, end_year, end_month, end_day)
    @currency_data = @get_data_object.collect_data(currency, start_year, start_month, start_day, end_year, end_month, end_day)
    @currency_data.shift
  end

  # creates graphs in png format
  # +currency+:: PLN/EUR - currency used to drwa charts
  def create_graph(currency)
    parse_date
    @get_data_object = GetData.new
    get_data(currency, @date_1_year, @date_1_month, @date_1_day, @date_2_year, @date_2_month, @date_2_day)
    @currency_data.each do |el|
      @currency_data_parsed.push(el.text.to_f)
    end
    create_graph_gchart(@currency_data_parsed, currency)
    @get_data_object.quit_driver
  end
  # Draw charts using google charts
  # Params:
  # +data+:: Currency data
  # +currency+:: PLN/EUR - currency used to drwa charts
  def create_graph_gchart(data,currency)
    Gchart.line(:title => currency.upcase+">USD",
                :data => data,
                :axis_with_labels => 'y',
                :min_value=>data.min-data.min*0.02,
                :size =>"500x500",
                :format => 'file')
  end
end
