# [Project Course in Scientific Computing]
# Tutor : Richard Tsai
# Projet : Monge Problem
# ========
#
# C. Voisembert
# -----------------------------------------------------------
# Function giving a number which will be used as a stop criteria, this number should be decrising.
# Input(s):
# - m_k [NxN Array{Array{Float64,1},2}]
# - delta_x [Float64] : accuratie of the mesh
# - p_0, p_1 [Array{Float64,2}] : grid representing the density of two propbabilities
# -----------------------------------------------------------

function stop_criteria(m_k,delta_x,p_0,p_1)

	N = round(Int, sqrt(length(m_k)))
	d = 2
	res_tot = 0

	for i in 1:N

 		resu = m_k[i][1] + m_k[i][2]
		if (i>1)	#left
			resu = resu - m_k[i-1][1]
		end
		if (i>N)	#behind
			 resu = resu - m_k[i-N][2]
		end

		resu = abs(1/delta_x*resu + p_1[i] - p_0[i])

		res_tot = res_tot + resu
	end
	res_tot = res_tot/N
	return res_tot

end
