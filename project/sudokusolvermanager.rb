require "./sudokusolverbot"
require 'thread'

# Class used to handle threading in program
class Manager

  # Initializes Manager
  # Params
  # +data+:: list of bots usernames and passwords
  def initialize(data)
    @bots_data = data
    @bots_list = []

    for tup in @bots_data
      @bot = SudokuSolverBot.new(tup[0], tup[1])
      @bots_list.push(@bot)
    end
  end

  # Functions used to start new bot - open driver and solving puzzle
  # Params
  # +bot_number+:: number of bot in list to be launched
  # +number_of_solutions+:: how many game loops to perform
  def start_bot(bot_number, number_of_solutions)
    bot = @bots_list[bot_number]
    bot.log_in
    sleep(2)  # solving MaxRetriesException
    bot.solve_loop(number_of_solutions)
    bot.driver.close
  end

  # Starts every bot on the list - invokes start_bot for every bot in list
  # Params
  # +number_of_solutions+:: how many games each bot should play
  def bot_manager_start(number_of_solutions)
    for i in 0...@bots_data.length
      Thread.new{start_bot(i, number_of_solutions)}
      sleep(3)
    end
  end
end

# Creates Manager instance and stars playing
# Params
# +data+:: information about bots usernames and passwords
# +count+:: how many games each bot should play
def start_manager(data, count)
  manager = Manager.new(data)
  manager.bot_manager_start(count)
end

