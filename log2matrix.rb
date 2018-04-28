require 'date'

def data2matrix(day,size,pre,data)
  n=0
  keys=(pre.keys + data.values.map{|h| h.keys}).flatten.uniq.sort
  mat=Array.new(size) {Array.new(keys.size,-1)}
  keys.each {|k| pre[k]=-1 if pre[k].nil?}  
  while (n<size) do
    day+=1
    if data[day]
      pre.update(data[day])
    end
    keys.each_index {|i| mat[n][i]=pre[keys[i]]} 
    n+=1
  end
  return mat
end

def update(data,pre,from,to,type,day,value)
  # puts ['update',data,pre,type,day,day_limit,value].inspect
  if day < from
    pre[type]=value
  elsif day > to
    skip
  else
    data[day]={} if data[day].nil?
    data[day][type]=value
  end
end

def update_ques(ques,size,type,value)
  if ques[type].nil?
    ques[type]=[value]
  else
    if value==0
      ques[type].unshift(value)
    else
      ques[type][0]+=value
    end
  end

  ques[type].pop if ques[type].length>size
  
end

def ques2matrix(ques,size)
  keys=ques.keys
  mat=Array.new(size) {Array.new(keys.size,-1)}
  keys.each_index do |i|
    q=ques[keys[i]]
    q.each_index do |j|
      mat[j][i]=q[j]
    end
  end
  return mat
end
  
def line_parse(line)
  return line.split(' ').map {|p| p.split}.flatten
end

def build_from_stream(stream,size)
  data={}
  pre={}
  stream.each do |line|
    current=line_parse(line)
    update_ques(data,size,current[2].to_i,current[3].to_i)
#    update(data, pre, day_limit, day_max, current[2].to_i, Date.parse(current[0]),current[3].to_i)
  end
  
  #return  data2matrix(day_limit,size,pre,data)
  #return ques2matrix(data,size)
  return data
end

def put_matrix (mat)
  mat.each do | l |
    puts l.join("\t")
  end
end
