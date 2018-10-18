def statystyka_slow(file_name)
  file = File.open(file_name, "r")
  text = file.read.gsub(/\W/, " ").downcase
  all_words_count = text.split.size/1.0
  frequencies = Hash.new(0)
  text.scan(/\w+/) { |word| frequencies[word] += 1 }
  frequencies.sort_by{|_key,value| value}.reverse.each do |key, value|
    puts "#{key}: #{value/all_words_count*100}%"
  end
end
statystyka_slow("text.txt")