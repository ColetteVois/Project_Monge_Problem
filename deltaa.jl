


function deltaa(x,p,delta)

  if (norm(x-p)<delta)
    res = 1/delta*cos(pi/2.0*norm(x-p)/delta)^2
  else
    res = 0
  end

  return res

end
