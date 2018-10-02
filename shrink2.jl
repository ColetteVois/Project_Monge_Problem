# [Project Course in Scientific Computing]
# Tutor : Richard Tsai
# Projet : Monge Problem
# ========
#
# C. Voisembert
# -----------------------------------------------------------
# Function which define the shink2 operation, used for the norm L2.
# Input(s):
# - y [2-element Array{Float64,1}]
# - alpha [Float64]
# Output :
# - res [Float64]
# -----------------------------------------------------------

function shrink2(y, alpha)
	epsi = 10.0^-5
	if (norm(y)==0)	#if the norm is 0 you can not divide by this norm
		res  = y*max(norm(y)-alpha,0)/(norm(y)+epsi)
	else
		res  = y*max(norm(y)-alpha,0)/(norm(y))
	end
	return res
end
