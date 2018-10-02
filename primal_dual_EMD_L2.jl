# [Project Course in Scientific Computing]
# Tutor : Richard Tsai
# Projet : Monge Problem
# ========
#
# C. Voisembert
# -----------------------------------------------------------
# Input(s):
# - p_0, p_1 [Array{Float64,2}] : grid representing the density of two propbabilities
# - m_0 [NxN Array{Array{Float64,1},2}]
# - mu, tau, theta, delta_x [Float64]
# -----------------------------------------------------------

include("/home/colette/Bureau/Monge_Problem/stop_criteria.jl")
include("/home/colette/Bureau/Monge_Problem/shrink2.jl")


function primal_dual_EMD_L2(p_0, p_1, m_0, mu, tau, theta, delta_x)

	epsi = 10.0^-5 	#iterate until convergence
	N = length(m_0)
	d = 2						#dimention 2

	#initialisation
	k = 0						#time
	m_0 = [[0.0,0.0] for i in 1:N, j in 1:N]
	phi_0 = zeros(N,N)
	m_k = m_0
	m_kplus1 = m_0
	phi_k = phi_0
	phi_kplus1 = phi_0
	debug = [[0.0,0.0,0.0] for i in 1:100]	#k,norm,stop
	norm_M = 0

	stop = stop_criteria(m_k,delta_x,p_0,p_1)
	while (stop > epsi) #(k<10001) #
		k = k + 1
		m_k = m_kplus1
		phi_k = phi_kplus1

		for i in 1:N
				# first row of the pseudo code
				resu = [0.0,0.0]
				resu[1] = - phi_k[i]
				resu[2] = - phi_k[i]
				if (i%N!=0) #boundary condition, 0 outside the grid
					resu[1] = resu[1] + phi_k[i+1]
				end
				if (i<(N*N-N+1))
					resu[2] = resu[2] + phi_k[i+N]
				end
				m_kplus1[i] = shrink2(m_k[i] + mu*1/delta_x*resu, mu)

				#second row of the pseudo code
				resu2 = (1+tau)*m_kplus1[i][1] - tau*m_k[i][1] + (1+tau)*m_kplus1[i][2] - tau*m_k[i][2]
				if (i>1)
					resu2 = resu2 - (1+tau)*m_kplus1[i-1][1] + tau*m_k[i-1][1]
				end
				if (i>N)
					resu2 = resu2 - (1+tau)*m_kplus1[i-N][2] + tau*m_k[i-N][2]
				end
				resu2 = resu2/delta_x
				phi_kplus1[i] = phi_k[i] + tau*(resu2 + p_1[i] - p_0[i])

		end
		stop = stop_criteria(m_k,delta_x,p_0,p_1)

		if(k%100==0 && k<10002)
			norm_M = 0
			for i in 1:length(m_kplus1)
				norm_M = norm_M + norm(m_kplus1[i])
			end
			norm_M = norm_M*delta_x*delta_x
			debug[round(Int,k/100)] = [k,norm_M,stop]
		end
	end

	print(debug)
	print("\n")
	print(k)
	print("\n")
	return(norm_M)
end
