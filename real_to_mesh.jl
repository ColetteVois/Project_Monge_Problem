


function real_to_mesh(x,N,delta_x)
  res = [floor(Int,N/2)+1+round(Int,x[1]/delta_x),floor(Int,N/2)+1+round(Int,x[2]/delta_x)]
  return res
end
