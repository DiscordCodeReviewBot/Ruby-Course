
class HomePage

  def initialize(driver)
    @driver = driver

    @currency_1_xpath = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/span[1]/span[1]/span[1]/span[1]"
    @pln_xpath = "/html[1]/body[1]/span[1]/span[1]/span[2]/ul[1]/li[2]/ul[1]/li[40]"
    @eur_xpath = "/html[1]/body[1]/span[1]/span[1]/span[2]/ul[1]/li[1]/ul[1]/li[2]"
    @reporting_period_xpath = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[3]/div[1]/span[1]/span[1]/span[1]/span[1]"
    @date_range_xpath = "/html[1]/body[1]/span[1]/span[1]/span[2]/ul[1]/li[10]"
    @first_date_xpath = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/input[1]"
    @second_date_xpath = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[2]/input[1]"
    @retrieve_data_xpath = "//button[@type='submit']"

    @star_year = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/select[1]"
    @start_month = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/select[2]"

    @end_year = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/select[1]"
    @end_month = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/select[2]"
  end

  def open_page
      @driver.get "https://www.ofx.com/en-au/forex-news/historical-exchange-rates/"
  end

  def click_curency_button
      @driver.find_element(:xpath, @currency_1_xpath).click
  end

  def choose_pln
      @driver.find_element(:xpath, @pln_xpath).click
  end

  def choose_eur
      @driver.find_element(:xpath, @eur_xpath).click
  end

  def click_reporting_period
      @driver.find_element(:xpath, @reporting_period_xpath).click
  end

  def choose_date_range
      @driver.find_element(:xpath, @date_range_xpath).click
  end

  def choose_start_year

  end

  def choose_start_month

  end

  def choose_start_day

  end

  def choose_end_year

  end

  def choose_end_month

  end

  def choose_end_day

  end
  def retrieve_data
      @driver.find_element(:xpath, @retrieve_data_xpath).click
  end

  def get_all_prices
      @driver.find_elements(:class, "historical-rates--table--rate")
  end
end