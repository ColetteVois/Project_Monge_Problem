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
	N = 40
	delta_x = (x_max-x_min)/N

	mu = 0.025
	tau = 0.025
	theta = 1.0
	eps = 10.0^-2

	p_0 = zeros(N,N)
	p_1 = zeros(N,N)
	m_0 = [[0.0,0.0] for i in 1:N, j in 1:N]

	#V = reshape(1:N*N, N, N)'


	#---------------------------Example 1------------------
	p_0[round(Int,N/2),round(Int,N/2)] = 1600
	p_0[round(Int,N/2)+1,round(Int,N/2)] = 1600
	p_0[round(Int,N/2),round(Int,N/2)+1] = 1600
	p_0[round(Int,N/2)+1,round(Int,N/2)+1] = 1600

	p_1[round(Int,N/2)+4,round(Int,N/2)+4] = 1600
	p_1[round(Int,N/2)+4,round(Int,N/2)+5] = 1600
	p_1[round(Int,N/2)+5,round(Int,N/2)+4] = 1600
	p_1[round(Int,N/2)+5,round(Int,N/2)+5] = 1600
	print(p_1)

	#primal_dual_EMD_L2(p_0, p_1, m_0, mu, tau, theta, delta_x)
	primal_dual_EMD_L1(p_0, p_1, m_0, eps, mu, tau, theta, delta_x)
end
