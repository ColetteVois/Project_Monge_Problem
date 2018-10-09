
include("/home/colette/Project_Monge_Problem/main.jl")

function complexity()

  N_tab = [33,43,51,61,71]
  tol_tab = [10.0^-4, 10.0^-4/2, 10.0^-4/4, 10.0^-4/8, 10.0^-4/16, 10.0^-4/32]
  time_N = [0,0,0,0,0]
  time_tol = [0,0,0,0,0,0]

  #complexity
  #tolerance with N fixed
  for i in 1:length(N_tab)
      time_N[i] = main(N_tab[i],tol_tab[1], [1,0], 0)[1]
  end
  #N with tol fixed
  for i in 1:length(tol_tab)
       time_tol[i] = main(N_tab[1],tol_tab[i], [1,0],0)[1]
  end

  #deplacement top
  moving_top = Array{Array{Float64,1}}(1, N, 1)
  for i in 1:length(N_tab)
      moving_top[i] = main(N_tab[i],tol_tab[5],[1,0],1)[2:3]
  end


  #deplacement right
  moving_right = Array{Array{Float64,1}}(1, N, 1)
  for i in 1:length(N_tab)
      moving_right[i] = main(N_tab[i],tol_tab[5],[0,1],1)[2:3]
  end

  #deplacement diagonal
  moving_diag = Array{Array{Float64,1}}(1, N, 1)
  for i in 1:length(N_tab)
      moving_diag[i] = main(N_tab[i],tol_tab[5],[1,1],1)[2:3]
  end

end
