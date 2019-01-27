def serialize(data)
  File.open("data.txt","wb") do |file|
    Marshal.dump(data,file)
  end
end
