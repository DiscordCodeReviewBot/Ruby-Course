
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

    @date_from = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/input[1]"
    @date_to = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[2]/input[1]"

    @star_year = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/select[1]"
    @start_month = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/select[2]"

    @end_year = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/select[1]"
    @end_month = "/html[1]/body[1]/div[1]/main[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/select[2]"
    @months_dict =
        {
            "01" => "j"
            "02" => "f"
            "03" => "m"
            "04" => "a"
            "05" => "mm"
            "06" => "jj"
            "07" => "jjj"
            "08" => "aa"
            "09" => "s"
            "10" => "o"
            "11" => "n"
            "12" => "d"
        }
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

  def click_date_from
    @driver.find_element(:xpath, @date_from).click
  end

  def click_date_to
    @driver.find_element(:xpath, @date_to).click
  end

  def choose_start_year(year)
    @driver.find_element(:xpath, @star_year).click
    @driver.find_element(:xpath, @star_year).send_keys(year+"\n")
  end

  def choose_start_month(month)
    @driver.find_element(:xpath, @star_month).click
  end

  def choose_start_day

  end

  def choose_end_year
    @driver.find_element(:xpath, @end_year).click
  end

  def choose_end_month
    @driver.find_element(:xpath, @end_month).click
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