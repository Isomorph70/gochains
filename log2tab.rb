require './log2matrix.rb'

size=7
data=build_from_stream($stdin,size)
mat= ques2matrix(data,size)
put_matrix(mat)
