require 'rubygems'
require 'nokogiri'
require 'open-uri'

class DistanceCounter

  def initialize(page_a, page_b, count)
    @page_a = page_a
    @page_b = page_b
    @page_nokogiri = Nokogiri::HTML(open(page_a))
    @count = count
    @links = @page_nokogiri.css("a")
    @linkslist = []
    @childrenlist = []
  end
  #
  # def create_links_and_children_list()
  #   @links.each do |link|
  #     @linkslist.push(link['href'])
  #     @childrenlist.push(DistanceCounter.new(link['href'], @link_b, @count+1))
  #   end
  #   puts "a'"
  # end

  def distance
    if @page_a == @page_b
      return @count
    end

  end
end

counter = DistanceCounter.new("https://www.wykop.pl/","https://www.wykop.pl/", 0)
puts counter.distance()