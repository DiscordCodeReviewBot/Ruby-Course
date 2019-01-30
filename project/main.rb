require 'tk'
require './sudokusolvermanager'
require "./informationManager"
require 'thread'

class MyGui

  def initialize
    @InfoManager = InformationManager.new

    @root = TkRoot.new
    @root.title = "SudokuKingdomBot"
    @root.height = 550
    @root.width = 550
    @root.minsize(550,550)
    @root.maxsize(550,550)

    @menu_start = TkMenu.new
    @start = TkMenu.new(@menu_start)

    @menu_start.add('cascade', :menu => @start, :label => 'Start')
    @start.add('command', :label => 'New Game',
                  :command => proc { Thread.new{start_manager(@InfoManager.accounts, 3)}})
    @start.add('command', :label => 'Add New User',
               :command => proc { add_new_user_create_gui})

    @root.menu(@menu_start)
    Tk.mainloop
  end

  def add_new_user_create_gui
    @new_user_window = TkToplevel.new
    @new_user_window.title = "Add New User"

    @first_entry = TkEntry.new(@new_user_window)
    @first_entry.width = 30
    @first_entry.insert '0', "Username"
    @second_entry = TkEntry.new(@new_user_window)
    @second_entry.width = 30
    @second_entry.insert '0', "password"
    @submit_button = TkButton.new(@new_user_window)
    @submit_button.text = "Submit"
    @submit_button.command = proc {submit_new_user}
    @first_entry.grid
    @second_entry.grid
    @submit_button.grid
  end

  def submit_new_user
    username = @first_entry.get
    password = @second_entry.get
    @new_user_window.destroy
    @InfoManager.add_new_user(username, password)
  end
end

mygui = MyGui.new
Thread.new{mygui}