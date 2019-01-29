require 'selenium-webdriver'

class SudokuSolverBot
  attr_reader :driver
  def initialize(username, password)
    options = Selenium::WebDriver::Chrome::Options.new
    #options.add_argument('--headless')
    @driver = Selenium::WebDriver.for :chrome, options: options
    @board = Array.new(9) { Array.new(9,"-")}
    @username = username
    @password = password
    @dont_click_list = []  # list of fields that are already filled on start
    @actions = ""  # actions to perform
    @number = 0  # we use this to get board info
  end

  def log_in
    @driver.get("https://www.sudokukingdom.com//index.php")
    @driver.find_element(:xpath, "//a[contains(text(),'Log In')]").click
    @driver.find_element(:xpath,"//input[@id='login_name']").send_keys(@username)
    @driver.find_element(:xpath,"//input[@id='member_password']").send_keys(@password)
    @driver.find_element(:xpath,"//input[@value='Log In']").click
  end

  def add_to_board(column, row, number)
    @board[column][row] = number
  end

  def get_board_info
    for i in 0...9
      for j in 0...9
        @number = @driver.find_element(:xpath,"//div[@id='vc_" + i.to_s + "_" + j.to_s + "']").text
        if not @number.scan(/\D/).empty?  # just double checking, without program is not consistent
          @number = @driver.find_element(:xpath, "//div[@id='vc_" + i.to_s + "_" + j.to_s + "']").text
        end

        if @number.scan(/\D/).empty?
          @dont_click_list.append(i.to_s + j.to_s)
        else
          @number = "-"
        end
        add_to_board(j, i, @number)
      end
    end
  end

  def fill_focus( element)
    @driver.find_element(:xpath, element).click
    sleep(0.08)
    @driver.find_element(:xpath, element).click
    sleep(0.08)
    @driver.find_element(:xpath, element).click
  end


  def fill_blank_spaces
    for i in 0...9
      for j in 0...9
        if not @dont_click_list.include?(j.to_s + i.to_s)
          sleep(3)
          @driver.find_element(:css, "#M"+@board[i][j].to_s).click
        end
        sleep(0.08)
        @driver.find_element(:css, "#M"+@board[i][j].to_s).click
        sleep(0.08)     # "//div[@id='vc_{}_{}']".format(j, i))
        fill_focus("//div[@id='vc_"+j.to_s+"_"+i.to_s+"']")
      end
    end
  end

  def solve_loop(number_of_solutions)
    for i in 0...number_of_solutions
      sleep(1)  # solving MaxRetriesException
      begin
        @driver.find_element(:xpath, "//div[@id='g4']").click  # very hard difficulty
      rescue "MaxRetriesException"  # solving MaxRetriesException
        #print("Bot {} łączy się ponownie". format(@username))
        nil
      end

      sleep(5)
      @driver.find_element(:xpath, "//div[@id='g4']").click
      #print("{} Etap I".format(self.username))
      @dont_click_list = []  # reseting list
      #print("{} Etap II".format(self.username))
      sleep(3)  # without this line sometimes program gets wrong board, how to solve?
      get_board_info
      #print("{} Etap III".format(self.username))
      File.open("boardinfo.txt", 'w') { |file| file.write(@board) }
      `python sudokusolver.py`
      @board = eval(File.read("boardresult.txt"))
      #print("{} Etap IV".format(self.username))
      fill_blank_spaces
      #print("{} Etap V".format(self.username))
      sleep(5)  # waiting until score updates (can do this by constantly checking score)
      #print("Bot {} completed task".format(self.username))
    end
  end
end
