# class which keeps informations about accounts
class InformationManager
  attr_reader :accounts
  # Initialize empty list
  def initialize
    @accounts = [
    ]
  end

  # Add new user to list
  # Params
  # +username+:: bots username
  # +password+:: bots password
  def add_new_user(username, password)
    @accounts.each do |tup|
      if tup[0] ==  username
        return false
      end
    end
     @accounts.push([username, password])
    print(@accounts)
  end

  # Delete user from list
  # Params
  # +username+:: bots username
  def delete_user(username)
    @accounts.each do |tup|
      if tup[0] ==  username
        @accounts.delete([username, tup[1]])
      end
    end
    print(@accounts)
  end
end

# Creates new instance of InformationManager or loads it from file
def create_information_manager
  if !File.file?("data.txt")
    info_manager = InformationManager.new
  else
    info_manager = nil
    File.open("data.txt","rb") {|f| info_manager = Marshal.load(f)}
  end
  info_manager
end

# Saves InformationManager instance to file
def serialize(info_manager)
  File.open("data.txt","wb") do |file|
    Marshal.dump(info_manager,file)
  end
end


