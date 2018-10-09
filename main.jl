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

include("/home/colette/Project_Monge_Problem/primal_dual_EMD_L2.jl")
include("/home/colette/Project_Monge_Problem/real_to_mesh.jl")
include("/home/colette/Project_Monge_Problem/mesh_to_real.jl")
include("/home/colette/Project_Monge_Problem/deltaa.jl")

#---------- Initialisaiton---------------
function main(N,tol, moving_direction,eloigne)

	if (N%2 == 0)
		print("Warning : N must be odd")
	end

	top = moving_direction[1]
	right = moving_direction[2]
	x_min = -2
	x_max = 2
	y_min = -2
	y_max = 2
	delta_x = (x_max-x_min)/(N-1)
	l0 = 0.4 #distance define around the center
	l1 = 0.3 #rayon of the pic
	step_point_inside = floor(l0/delta_x)	#how many point with a value in the distributions p_0, p_1
	mu = 0.0003 #0.025 #if mu bigger, it goes faster
	tau = 3# 0.025 #if tau bigger, it goes faster
	theta = 1.0

	#initialisation
	p_0 = zeros(N,N)
	p_1 = zeros(N,N)
	m_0 = Array{Array{Float64,1}}(1, N, N)
	for I in eachindex(m_0)
		m_0[I]= zeros(2)
	end
	approximate_distance_p0_p1 = 0.0
	time = 0.0
	norm_M = 0.0
	if (eloigne==1)
		norm_M_tab = zeros(10)
		approximate_distance_p0_p1_tab = zeros(10)
	else
		norm_M_tab = 0.0
		approximate_distance_p0_p1_tab = 0.0
	end

	#---------------------------Example 1------------------
	center_p0 = [0.0,0.0]

	for indice in (1+9*eloigne):10

		#define p_0 and p_1
		center_p1 = [top*indice*0.1,right*indice*0.1]
		center_p0_fem = real_to_mesh(center_p0,N,delta_x)
		center_p1_fem = real_to_mesh(center_p1,N,delta_x)

		for i in 0:step_point_inside
			for j in 0:step_point_inside
				for k in [-1,1]
					for l in [-1,1]
						i_mesh = center_p0_fem[1] + k*i
						j_mesh = center_p0_fem[2] + l*j
						x_0 = mesh_to_real([i_mesh,j_mesh],N,delta_x)
						p_0[i_mesh, j_mesh] = deltaa(x_0, center_p0, l1)

						i_mesh = center_p1_fem[1] + k*i
						j_mesh = center_p1_fem[2] + l*j
						p_1[i_mesh, j_mesh] = deltaa(mesh_to_real([i_mesh,j_mesh],N,delta_x), center_p1, l1)
					end
				end
			end
		end

		#write matrix to plot it with python
		s=open("/home/colette/Project_Monge_Problem/p_0.txt", "w");
		write(s,"$p_0");
		close(s);
		s=open("/home/colette/Project_Monge_Problem/p_1.txt", "w");
		write(s,"$p_1");
		close(s);

		approximate_distance_p0_p1 = norm(center_p0-center_p1)

		time = @elapsed norm_M=primal_dual_EMD_L2(p_0, p_1, m_0, mu, tau, theta, delta_x,tol)

		if (eloigne==1)
			norm_M_tab[indice] = norm_M
			approximate_distance_p0_p1_tab[indice] = approximate_distance_p0_p1
		else
			norm_M_tab = norm_M
			approximate_distance_p0_p1_tab = approximate_distance_p0_p1
		end
	end

	return(time, approximate_distance_p0_p1_tab, norm_M_tab)
end
