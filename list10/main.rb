require 'selenium-webdriver'
require './homePage'
require './getData'
require 'tk'


def serialize(data)
  File.open("data.txt","wb") do |file|
    Marshal.dump(data,file)
  end
end


class MyGUI
  def initialize
    @root = TkRoot.new
    @root.title = "Currency Charts"
    @root.height = 500
    @root.width = 800
=begin
    @canvas = TkCanvas.new
    @canvas.height = 500
    @canvas.width = 800
    @canvas.image()
=end
    menu = TkMenu.new
    new_graph = TkMenu.new(menu)

    menu.add('cascade', :menu => new_graph, :label => 'New Graph')
    new_graph.add('command', :label => 'EUR -> USD',
            :command => proc { create_and_update_graph })
    new_graph.add('command', :label => 'PLN -> USD',
            :command => proc { create_and_update_graph})

    @root.menu(menu)
    Tk.mainloop
  end

  def new_background
    image = TkPhotoImage.new
    image.file = "image.png"
    label = TkLabel.new(@root)
    label.image = image
    label.place('x' => 0, 'y' => 0)
  end

  def eur_graph
    puts "xd"
  end

end






my_gui = MyGUI.new

=begin
    menu = TkMenu.new(root)
    menu.add('command',
             'label'     => "EUR - USD",
             'command'   => 1,
             'underline' => 0)
    menu.add('command',
             'label'     => "PLN - USD",
             'command'   => root.destroy,
             'underline' => 0)

    menu_bar = TkMenu.new
    menu_bar.add('cascade',
                 'menu'  => menu,
                 'label' => "Graph")
    root.menu(menu_bar)
=end