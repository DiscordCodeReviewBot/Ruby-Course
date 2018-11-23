require "sqlite"


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

  def initialize(database, user, password)
    begin
      @con = PG.connect :dbname => database, :user => user, :password => password
      rescue PG::ConnectionBad => e
      puts "DATABASE DOES NOT EXIST"
    end
  end

  def create_tables
    @con.exec "CREATE TABLE CDS(id INTEGER PRIMARY KEY,
        Title VARCHAR(30), Price INT)"
  end

end

db = DatabaseManager.new("cds", "postgres", 1234)