require 'selenium-webdriver'
require './homePage'
class GetData

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    @homepage = HomePage.new(@driver)
  end

  def collect_data(currency, start_year, start_month, start_day, end_year, end_month, end_day)
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
    sleep(1)
    @homepage.choose_start_month(start_month)
    sleep(1)
    @homepage.choose_start_day(start_day)
    sleep(1)
    @homepage.click_date_to
    sleep(1)
    @homepage.choose_end_year(end_year)
    sleep(1)
    @homepage.choose_end_month(end_month)
    sleep(1)
    @homepage.choose_end_day(end_day)
    sleep(1)
    @homepage.retrieve_data
    sleep(4)
    prices = @homepage.get_all_prices
  end
end

get_data = GetData.new
get_data.collect_data("pln", "1999", "07", "01", "2019", "01","21")