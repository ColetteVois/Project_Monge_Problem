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

function stop_criteria(m_k,delta_x,p_0,p_1)

	N = round(Int, sqrt(length(m_k)))
	d = 2
	res_tot = 0

	for i in 1:N
 		resu = m_k[i]
		if (i>1)
			resu = resu - m_k[i-1]
		end
		if (i<N*(N-1))
			 resu = resu + m_k[i+N]
		end
		if (i>N+1)
			resu = resu - m_k[i-N]
		end
		resu = abs(1/delta_x*(resu + p_1[i] - p_0[i]))

		res = 0
		for j in 1:d
			res = res + resu[j]
		end
		res_tot = res_tot + res
	end
	res_tot = res_tot/N
	return res_tot


end
