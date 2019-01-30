

class InformationManager
  attr_reader :accounts
  def initialize
    @accounts = [
        ['binq', 'marcin1234'],
        ['binq', 'marcin1234']
    ]
  end

  def add_new_user(username, password)
    @accounts.push([username, password])
  end
end