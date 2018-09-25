# [Project Course in Scientific Computing]
# Tutor : Richard Tsai
# Projet : Monge Problem
# ========
#
# C. Voisembert
# -----------------------------------------------------------
# Fonction utile pour transformer une matrice en vecteur en
# concaténant ses lignes les unes à la suite des autres.
# Input(s):
# - y [matrix in R^d] : matrice à transformer
# - alpha [nimber in R] :
# -----------------------------------------------------------

include("/home/colette/Bureau/Monge_Problem/stop_criteria.jl")
include("/home/colette/Bureau/Monge_Problem/shrink1.jl")

function primal_dual_EMD_L1(p_0, p_1, m_0, eps, mu, tau, theta, delta_x)

	epsi = 10.0^-5 #iterate until convergence
	N = length(m_0)
	d = 2

	#initialisation
	k = 0
	m_0 = [[0.0,0.0] for i in 1:N, j in 1:N]
	phi_0 = zeros(N,N)
	m_k = [[0.0,0.0] for i in 1:N, j in 1:N]
	m_kplus1 = m_0
	phi_k = phi_0
	phi_kplus1 = phi_0

	stop = stop_criteria(m_k,delta_x,p_0,p_1)
	while (stop > epsi)
		k = k + 1
		m_k = m_kplus1
		phi_k = phi_kplus1

		for i in 1:N
				print(i)
				# first row of the pseudo code
				resu = [0.0,0.0]
				resu[1] = - phi_k[i]
				resu[2] = - phi_k[i]
				if (i%N!=0)
					resu[1] = resu[1] + phi_k[i+1]
				end
				if (i>N)
					resu[2] = resu[2] + phi_k[i+N]
				end
				print(m_k[i] + mu*resu)
				for j in 1:2
					m_kplus1[i][j] = shrink1(m_k[i][j]*1.0 + 1.0*mu*resu[j], 1.0*mu)*1.0/(1.0+eps*tau)
				end

				#second row of the pseudo code
				resu2 = (1+tau)*m_kplus1[i][1] - tau*m_k[i][1] + (1+tau)*m_kplus1[i][2] - tau*m_k[i][2]
				if (i>1)
					resu2 = resu2 - (1+tau)*m_kplus1[i-1][1] + tau*m_k[i-1][1]
				end
				if (i>N)
					resu2 = resu2 - (1+tau)*m_kplus1[i-N][2] + tau*m_k[i-N][2]
				end
				resu2 = resu2*delta_x
				phi_kplus1[i] = phi_k[i] + tau*(resu2 + p_1[i] - p_0[i])

		end
		stop = stop_criteria(m_k,delta_x,p_0,p_1)
	end
	norm_M = 0
	for i in 1:length(m_kplus1)
		norm_M = norm_M + norm(m_kplus1[i])
	end

	return(norm_M)
end
