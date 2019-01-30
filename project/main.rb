require 'tk'
require './sudokusolvermanager'
require "./informationManager"
require 'thread'
require "mini_magick"

# Class used to create GUI - adding buttons and commands to them
class MyGui

  # Initialize main window
  def initialize
    @info_manager = create_information_manager
    Thread.new{new_background}
    @root = TkRoot.new
    @root.title = "SudokuKingdomBot"
    @root.height = 900
    @root.width = 600
    @root.minsize(900,600)
    @root.maxsize(900,600)

    @menu_start = TkMenu.new
    @start = TkMenu.new(@menu_start)

    @menu_start.add('cascade', :menu => @start, :label => 'Start')
    @start.add('command', :label => 'New Game',
                  :command => proc { how_many_games_gui})
    @start.add('command', :label => 'Add New User',
               :command => proc { add_new_user_create_gui})
    @start.add('command', :label => 'Delete User',
               :command => proc { delete_user_create_gui})

    @root.menu(@menu_start)
    Tk.mainloop
  end

  # Change main window background to screenshot from game
  def new_background
    a = 10
    while true
      if a&10 == 0
        image = MiniMagick::Image.open("screenshot.png")
        image.resize "800x500"
        image.format "png"
        image.write "screenshot2.png"
        image2= TkPhotoImage.new
        image2.file = "screenshot2.png"
        label = TkLabel.new(@root)
        label.image = image2
        label.place('x' => 50, 'y' => 70)
      end
      sleep(1)
      a = a+1
    end

  end

  # Creates new winndow to get information about number of games
  def how_many_games_gui
    @how_many_games_window = TkToplevel.new
    @how_many_games_window.title = "How many games?"

    @first_entry = TkEntry.new(@how_many_games_window)
    @first_entry.width = 30
    @first_entry.insert '0', "How many games?"
    @submit_button = TkButton.new(@how_many_games_window)
    @submit_button.text = "Submit"
    @submit_button.command = proc {submit_how_many_games}
    @first_entry.grid
    @submit_button.grid
  end

  # Invokes submit function for submit button in how_many_games_window
  def submit_how_many_games
    count = @first_entry.get
    @how_many_games_window.destroy
    Thread.new{start_manager(@info_manager.accounts, count.to_i)}
  end
  # Thread.new{start_manager(@info_manager.accounts, 3)}

  # Creates new winndow to get information about user who needs to be added
  def add_new_user_create_gui
    @new_user_window = TkToplevel.new
    @new_user_window.title = "Add New User"

    @first_entry = TkEntry.new(@new_user_window)
    @first_entry.width = 30
    @first_entry.insert '0', "Username"
    @second_entry = TkEntry.new(@new_user_window)
    @second_entry.show = "*"
    @second_entry.width = 30
    @second_entry.insert '0', "password"
    @submit_button = TkButton.new(@new_user_window)
    @submit_button.text = "Submit"
    @submit_button.command = proc {submit_new_user}
    @first_entry.grid
    @second_entry.grid
    @submit_button.grid
  end

  # Creates new winndow to get information about user who needs to be deleted
  def delete_user_create_gui
    @delete_user_window = TkToplevel.new
    @delete_user_window.title = "Delete User"

    @first_entry = TkEntry.new(@delete_user_window)
    @first_entry.width = 30
    @first_entry.insert '0', "Username"
    @submit_button = TkButton.new(@delete_user_window)
    @submit_button.text = "Submit"
    @submit_button.command = proc {submit_delete_user}
    @first_entry.grid
    @submit_button.grid
  end

  # Invokes submit function for submit button in delete_user_window
  def submit_delete_user
    username = @first_entry.get
    @delete_user_window.destroy
    @info_manager.delete_user(username)
    serialize(@info_manager)
  end
  # Invokes submit function for submit button in add_new_user_window
  def submit_new_user
    username = @first_entry.get
    password = @second_entry.get
    @new_user_window.destroy
    @info_manager.add_new_user(username, password)
    serialize(@info_manager)
  end
end

mygui = MyGui.new
Thread.new{mygui}