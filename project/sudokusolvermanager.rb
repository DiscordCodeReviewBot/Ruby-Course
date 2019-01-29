require "./sudokusolverbot"

class Manager

  def initialize
    @bots_data = [
        ['binq', 'marcin1234'],
    ]
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

manager = Manager.new
manager.bot_manager_start(1)
