

class Person

  attr_reader :cust_name
  attr_reader :cust_number
  attr_reader :cust_groups

  def initialize(name, number, groups)
    @cust_name = name
    @cust_number = number
    @cust_groups = groups
  end

end

class Notepad

  attr_reader :cust_list

  def initialize()
    @cust_list = []
  end

  def add_new_person(person)
    @cust_list.push(person)
  end

  def search_by_name(name)
    for i in cust_list
      if i.cust_name === name
        return i
      end
    end
  end

  def find_all_groups()
    @all_groups_list = []
    for i in cust_list
      for j in i.cust_groups
        if !@all_groups_list.include? j
          @all_groups_list.push(j)
          print j, ", "
        end
      end
    end
  end

  def find_all_in_group(group_name)
    for i in cust_list
      for j in i.cust_groups
        if j === group_name
          print(i.cust_name," ",search_by_name(i.cust_name).cust_number,"\n")
        end
      end
    end
  end


end


my_notepad = Notepad.new

my_notepad.add_new_person(Person.new("Marcin",664993219, ["me", "family"]))
my_notepad.add_new_person(Person.new("Monika",664993221, ["family"]))
my_notepad.add_new_person(Person.new("Edyta",664993225, ["family", "parents"]))
my_notepad.add_new_person(Person.new("Leszek",664993225, ["family", "parents"]))
my_notepad.add_new_person(Person.new("Patryk",505501765, ["friends", "bestfriends"]))
my_notepad.add_new_person(Person.new("Paweł",505545125, ["friends"]))
my_notepad.add_new_person(Person.new("Piotr",664946521, ["friends", "school"]))
my_notepad.add_new_person(Person.new("Michał",664946521, ["friends", "bestfriends", "school", "work"]))

while true
  print "quit, ", "add, ", "search, ", "group, ", "all groups: "
  x = gets.chomp
  if x=="quit"
    break
  elsif x=="add"
    groups = []
    print "\nname: "
    name = gets.chomp
    print "number: "
    number = gets.chomp
    while true
      print "group: "
      temp = gets.chomp
      groups.push(temp)
      while true
        print"all? (yes/no)"
        answer = gets.chomp
        if answer=="yes" or answer=="no"
          break
        end
      end
      if answer=="yes"
        break
      end
    end
    my_notepad.add_new_person(Person.new(name, number, groups))
  elsif x == "search"
    print "name: "
    name = gets.chomp
    print my_notepad.search_by_name(name).cust_name," ", my_notepad.search_by_name(name).cust_number,"\n"
  elsif x == "group"
    print "\ngroup name: "
    group = gets.chomp
    puts
    my_notepad.find_all_in_group(group)
    puts
  elsif x == "all groups"
    print "\ngroups: "
    my_notepad.find_all_groups
    puts "\n\n"
  end
end
