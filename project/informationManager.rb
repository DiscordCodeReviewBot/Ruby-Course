
class InformationManager
  attr_reader :accounts
  def initialize
    @accounts = [
        ['binq', 'marcin1234'],
    ]
  end

  def add_new_user(username, password)
    @accounts.each do |tup|
      if tup[0] ==  username
        return false
      end
    end
     @accounts.push([username, password])
    print(@accounts)
  end

  def delete_user(username)
    @accounts.each do |tup|
      if tup[0] ==  username
        @accounts.delete([username, tup[1]])
      end
    end
    print(@accounts)
  end
end

def create_information_manager
  if !File.file?("data.txt")
    info_manager = InformationManager.new
  else
    info_manager = nil
    File.open("data.txt","rb") {|f| info_manager = Marshal.load(f)}
  end
  info_manager
end

def serialize(info_manager)
  File.open("data.txt","wb") do |file|
    Marshal.dump(info_manager,file)
  end
end


