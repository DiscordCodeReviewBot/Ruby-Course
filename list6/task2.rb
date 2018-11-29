require 'uri'

class Person
  attr_reader :id, :name, :surname, :nick, :email,:number
  def initialize(my_id, name, surname, nick, email, number)
    @id = my_id.to_s
    @name = name.to_s
    @surname = surname.to_s
    @nick = nick.to_s
    @email = nil
    self.check_email(email)
    @number = nil
    self.check_number(number)
  end

  def to_s
    [@id,@name, @surname, @nick, @email, @number].join(", ")
  end
  def check_email(email)
    if email.match(URI::MailTo::EMAIL_REGEXP)
      @email = email.to_s
    else
      print("Not valid email...try again: ")
      new_email = gets.chomp
      check_email(new_email)
    end
  end

  def check_number(number)
    if number.to_s.match(/^[0-9]{9}$/)
      @number = number.to_s
    else
      print("Not valid number...try again: ")
      new_number = gets.chomp
      check_number(new_number)
    end
  end
end

class Notepad
  attr_reader :person_list
  def initialize
    @person_list = []
  end

  def add_person(person)
    @person_list.push(person)
  end

  def remove_person(my_id)
    @person_list.each do |person|
      if person.id == my_id.to_s
        @person_list.delete(person)
      end
    end
  end

  def print_info(my_id)
    @person_list.each do |person|
      if person.id == my_id.to_s
        puts person
      end
    end
  end
  def print_all
    @person_list.each {|p| puts p}
  end
end


def get_data
  if !File.file?("notepad.txt")
    my_notepad = Notepad.new
  else
    File.open("notepad.txt","rb") {|f| my_notepad = Marshal.load(f)}
  end
end

def serialize(my_notepad)
  File.open("notepad.txt","wb") do |file|
    Marshal.dump(my_notepad,file)
  end
end


my_notepad = get_data
while true
  print("\nAdd Person[1], Remove Person[2], Search For Person[3], Show All[4], Quit[0]: ")
  action = gets.chomp.to_s
  case action
  when '0'
    break
  when '1'
    print("id: ")
    my_id = gets.chomp.to_s
    print("Name: ")
    name = gets.chomp.to_s
    print("Surname: ")
    surname = gets.chomp.to_s
    print("Nick: ")
    nick = gets.chomp.to_s
    print("Email: ")
    email = gets.chomp.to_s
    print("Number: ")
    number = gets.chomp.to_s
    my_notepad.add_person(Person.new(my_id, name, surname, nick, email, number))
  when '2'
    print("id: ")
    my_id = gets.chomp
    my_notepad.remove_person(my_id)
  when '3'
    print("id: ")
    my_id = gets.chomp
    my_notepad.print_info(my_id)
  when '4'
    my_notepad.print_all
  else
    puts "Wrong Input"
  end

  serialize(my_notepad)
end