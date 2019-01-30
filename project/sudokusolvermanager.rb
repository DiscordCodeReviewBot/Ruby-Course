require "./sudokusolverbot"
require 'thread'

class Manager

  def initialize(data)
    @bots_data = data
    @bots_list = []

    for tup in @bots_data
      @bot = SudokuSolverBot.new(tup[0], tup[1])
      @bots_list.push(@bot)
    end
  end

  def start_bot(bot_number, number_of_solutions)
    bot = @bots_list[bot_number]
    bot.log_in
    sleep(2)  # solving MaxRetriesException
    bot.solve_loop(number_of_solutions)
    bot.driver.close
  end

  def bot_manager_start(number_of_solutions)
    for i in 0...@bots_data.length
      start_bot(i, number_of_solutions)
    end
  end
end

def start_manager(data, count)
  manager = Manager.new(data)
  manager.bot_manager_start(count)
end

