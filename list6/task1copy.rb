require 'dbm'
require "date"
class CdDisk
  attr_reader :title, :artists, :songs_list, :borrowed_to, :cd_id

  def initialize(cd_id, title, artists, songs_list, borrowed_to=nil, return_date=nil )
    @cd_id = cd_id
    @title = title
    @artists = artists
    @songs_list = songs_list
    @borrowed_to = borrowed_to
    @return_date = return_date
  end
  def to_s
    @cd_id
  end
  def lend(person_name, year, month, day)
    @borrowed_to = person_name
    @return_date = Date.new(year, month, day)
  end

  def return_to_owner
    @borrowed_to = nil
  end

  def can_be_borrowed
    if @borrowed_to == nil
      true
    else
      false
    end
  end

  def check_return_date
    if @return_date == nil
      false
    end
    if Date.parse(@return_date) > Date.today
      true
    else
      false
    end
  end
end


class DatabaseManager
  
  def initialize(database)
    @database = database
  end
  
  def add_to_database(cd)
    DBM.open(@database) do |db|
      db[cd.cd_id] = cd
    end
  end

  def get_data_from_database(cd_id)
    db = DBM.open(@database)
    return db[cd_id]
  end


  def get_list_of_names_with_cds_after_time
    DBM.open(@database) do |db|
      db.each {|k,v| puts "#{k} => #{v.to_s}"}
    end
  end





  # def get_list_of_names_with_cds_after_time
  #   name_cd = []
  #   DBM.open(@database) do |db|
  #     db.each do |k, v|
  #       if v.check_return_date()
  #         name_cd.push([v.borrowed_to,v.title])
  #       end
  #     end
  #   end
  #   name_cd
  # end
end


disk = CdDisk.new("1","title1",["name","name2"],["asd","dsad"] )
disk.lend("Marcin", 2001, 10, 2)

disk2 = CdDisk.new("2","title",["name","name2"],["asd","dsad"] )
disk2.lend("Marcin", 2001, 10, 2)

dbmanager = DatabaseManager.new("database")
dbmanager.add_to_database(disk)
dbmanager.add_to_database(disk2)
dbmanager.get_list_of_names_with_cds_after_time
