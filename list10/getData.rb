require 'selenium-webdriver'
require './homePage'
class GetData

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    @homepage = HomePage.new(@driver)
  end

  def collect_data(currency, start_year, start_month)
    @homepage.open_page
    @homepage.click_curency_button
    if currency == "pln"
      @homepage.choose_pln
    else
      @homepage.choose_eur
    end
    @homepage.click_reporting_period
    @homepage.choose_date_range
    @homepage.click_date_from
    sleep(1)
    @homepage.choose_start_year(start_year)
    @homepage.choose_start_month(start_month)
    #@homepage.retrieve_data
    sleep(15)
    prices = @homepage.get_all_prices
    puts(prices)
  end
end

get_data = GetData.new
get_data.collect_data("pln", "1999", "10")