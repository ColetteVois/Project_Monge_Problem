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



function shrink1(y, alpha)
	res  = sign(y)*max(abs(y) - alpha,0)
	return res
end
