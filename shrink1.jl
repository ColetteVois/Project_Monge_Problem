# [Project Course in Scientific Computing]
# Tutor : Richard Tsai
# Projet : Monge Problem
# ========
#
# C. Voisembert
# -----------------------------------------------------------
# Function which define the shink1 operation, used for the norm L1.
# Input(s):
# - y [1-element Array{Float64,1}]
# - alpha [Float64]
# Output :
# - res [Float64]
# -----------------------------------------------------------



function shrink1(y, alpha)
	res  = sign(y)*max(abs(y) - alpha,0)
	return res
end
