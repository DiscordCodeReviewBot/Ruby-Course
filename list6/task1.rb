require "date"
class CdDisk
  attr_reader :title, :artist, :songs_list, :borrowed_to, :cd_id, :return_date

  def initialize(cd_id, title, artist, songs_list)
    @cd_id = cd_id
    @title = title
    @artist = artist
    @songs_list = songs_list
    @borrowed_to="Nobody"
    @return_date = "Not Borrowed"
  end

  def to_s
    "ID: " + @cd_id + " title: " + @title + " artist: " + @artist + " songs: " + @songs_list + " borrowed to: " + borrowed_to + " return date: " + @return_date.to_s + "\n"
  end

  def lend(person_name, year, month, day)
    @borrowed_to = person_name
    @return_date = Date.new(year, month, day)
  end

  def return_to_owner
    @borrowed_to = "Nobody"
    @return_date = "Not Borrowed" 
  end

  def check_return_date
    if @return_date == "Not Borrowed"
      false
    elsif @return_date < Date.today
	puts "ID: " + @cd_id + " title: " + @title + " artist: " + @artist + " songs: " + @songs_list + " borrowed to: " + borrowed_to + " return date: " + @return_date.to_s + "\n"
    else
      false
    end
  end
end

class Album
	attr_reader :all_cds
	def initialize
		@all_cds = []
	end

	def to_s
		s=""
		@all_cds.each do |cd|
			s = s + cd.to_s
		end
		s
		
	end
	def add_cd(cd)
		@all_cds.push(cd)	
	end

	def remove_cd(id)
		@all_cds.each do |cd|
			if cd.cd_id == id.to_s
				@all_cds.delete(cd)
			end		
		end
	end

	
end

def serialize(album)
	File.open("data.txt","wb") do |file|
		Marshal.dump(album,file)
	end
end





if !File.file?("data.txt")
	album = Album.new
else
	album = nil
	File.open("data.txt","rb") {|f| album = Marshal.load(f)}
end

while true
	puts
	print "quit[0], add album[1], remove album[2], lend album[3], check for an overdue[4], show cd info[5], return to owner[6]: "
	action = gets.chomp
	puts
	if action == "0"
		break	
	end
	if action == "1"
		print "id: "
		id = gets.chomp.to_str
		print "title: "
		title = gets.chomp
		print "artist: "
		artist = gets.chomp
		print "songs: "
		songs = gets.chomp.to_s
		my_cd = CdDisk.new(id, title, artist, songs)
		album.add_cd(my_cd)
	end
	
	if action == "2"
		print "id: "
		id = gets.chomp.to_str
		album.all_cds.each do |cd|
			album.remove_cd(id)
		end
	end


	if action == "3"
		print "id: "
		id = gets.chomp.to_str
		print "Name: "
		name = gets.chomp
		print "year: "
		year = gets.chomp.to_i
		print "month: "
		month = gets.chomp.to_i
		print "day: "
		day = gets.chomp.to_i

		album.all_cds.each do |cd|
			if cd.cd_id == id
				cd.lend(name,year,month,day)			
			end
		end
	end

	if action == "4"
		puts "overdue cds:"
		album.all_cds.each do |cd|
			cd.check_return_date
		end
	end

	if action == "5"
		print "cd id / all: "
		id = gets.chomp.to_str
		puts
		if id == "all"
			puts album.all_cds	

		else
			album.all_cds.each do |cd|
				if cd.cd_id == id
					puts cd
				end
			end	
		end
		
		
	end

	if action == "6"
		print "id: "
		id = gets.chomp.to_s
		print
		album.all_cds.each do |cd|
			if cd.cd_id == id
				cd.return_to_owner			
			end
		end
	end
	serialize(album)
end

