

class InformationManager
  attr_reader :accounts
  def initialize
    @accounts = []
  end

  def add_new_user(username, password)
    @accounts.push([username, password])
  end
end