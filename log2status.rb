require './log2matrix.rb'

size=1
data=build_from_stream($stdin,size)
data.each do |k, v|
puts [k,v[0]].join("\t") if v.length>0
end

