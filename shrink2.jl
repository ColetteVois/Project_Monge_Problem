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



function shrink2(y, alpha)
	epsi = 10.0^-5
	if (norm(y)==0)
		#print("if")
		res  = y*max(norm(y)-alpha,0)/(norm(y)+epsi)
	else
		#print("else")
		res  = y*max(norm(y)-alpha,0)/(norm(y))
	end
	return res
end
