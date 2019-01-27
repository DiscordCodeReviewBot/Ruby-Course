require 'selenium-webdriver'
require './homePage'

class GetData

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    @homepage = HomePage.new(@driver)
  end
  def collect_data(currency)
    @homepage.open_page
    @homepage.click_curency_button
    if currency == "pln"
      @homepage.choose_pln
    else
      @homepage.choose_eur
    end
    @homepage.click_reporting_period
    @homepage.choose_date_range
    @homepage.retrieve_data
    sleep(5)
    prices = @homepage.get_all_prices
    puts(prices)
  end

end

xd = GetData.new
xd.collect_data("pln")