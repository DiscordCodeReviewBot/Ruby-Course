class GetData

  # Initialize webdriver and add options
  def initialize
    options = Selenium::WebDriver::Chrome::Options.new
    #options.add_argument('--headless')
    @driver = Selenium::WebDriver.for :chrome, options: options
    @homepage = HomePage.new(@driver)
  end

  # Collects data for charts
  # Params:
  # +currency+:: PLN/EUR - currency used to drwa charts
  # +start_year+:: start year for date range
  # +start_month+:: start month for date range
  # +start_day+:: start day for date range
  # +end_year+:: end year for date range
  # +end_month+:: end month for date range
  # +end_day+:: end day for date range
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
    sleep(7)
    @homepage.get_all_prices
  end
  # Closes webdriver
  def quit_driver
    @driver.quit
  end
end