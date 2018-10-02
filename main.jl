# [Project Course in Scientific Computing]
# Tutor : Richard Tsai
# Projet : Monge Problem
# ========
#
# C. Voisembert
# -----------------------------------------------------------
# Main
# -----------------------------------------------------------

#-------------------Includes--------------------------

include("/home/colette/Bureau/Monge_Problem/primal_dual_EMD_L2.jl")
include("/home/colette/Bureau/Monge_Problem/primal_dual_EMD_L1.jl")

#---------- Initialisaiton---------------
function main()
	x_min = -2
	x_max = 2
	y_min = -2
	y_max = 2
	N = 33
	delta_x = (x_max-x_min)/(N-1)

	mu = 0.0003 #0.025 #if mu bigger, it goes faster
	tau = 3# 0.025 #if tau bigger, it goes faster
	theta = 1.0
	eps = 10.0^-2

	p_0 = zeros(N,N)
	p_1 = zeros(N,N)
	m_0 = [[0.0,0.0] for i in 1:N, j in 1:N]


	#---------------------------Example 1------------------

	i_p0 = 0
	i_p1 = 6
	h = 1.0/(4*delta_x*delta_x)

	p_0[floor(Int,N/2)+1+i_p0,floor(Int,N/2)+1+i_p0] = h
	p_0[floor(Int,N/2)+1+i_p0,floor(Int,N/2)+1+1+i_p0] = h
	p_0[floor(Int,N/2)+1+i_p0,floor(Int,N/2)+1-1+i_p0] = h
	p_0[floor(Int,N/2)+1+1+i_p0,floor(Int,N/2)+1+i_p0] = h
	p_0[floor(Int,N/2)+1+1+i_p0,floor(Int,N/2)+1+1+i_p0] = h
	p_0[floor(Int,N/2)+1+1+i_p0,floor(Int,N/2)+1-1+i_p0] = h
	p_0[floor(Int,N/2)+1-1+i_p0,floor(Int,N/2)+1+i_p0] = h
	p_0[floor(Int,N/2)+1-1+i_p0,floor(Int,N/2)+1+1+i_p0] = h
	p_0[floor(Int,N/2)+1-1+i_p0,floor(Int,N/2)+1-1+i_p0] = h


	p_1[floor(Int,N/2)+1+i_p1,floor(Int,N/2)+1] = h
	p_1[floor(Int,N/2)+1+i_p1,floor(Int,N/2)+1+1] = h
	p_1[floor(Int,N/2)+1+i_p1,floor(Int,N/2)+1-1] = h
	p_1[floor(Int,N/2)+1+1+i_p1,floor(Int,N/2)+1] = h
	p_1[floor(Int,N/2)+1+1+i_p1,floor(Int,N/2)+1+1] = h
	p_1[floor(Int,N/2)+1+1+i_p1,floor(Int,N/2)+1-1] = h
	p_1[floor(Int,N/2)+1-1+i_p1,floor(Int,N/2)+1] = h
	p_1[floor(Int,N/2)+1-1+i_p1,floor(Int,N/2)+1+1] = h
	p_1[floor(Int,N/2)+1-1+i_p1,floor(Int,N/2)+1-1] = h

	approximate_distance_p0_p1 = norm([delta_x*i_p0-delta_x*i_p1,delta_x*i_p0-delta_x])
	print(approximate_distance_p0_p1)
	print("\n")

	primal_dual_EMD_L2(p_0, p_1, m_0, mu, tau, theta, delta_x)
	#	primal_dual_EMD_L1(p_0, p_1, m_0, eps, mu, tau, theta, delta_x)
end
