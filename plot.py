from mpl_toolkits.mplot3d import Axes3D  # noqa: F401 unused import

import numpy as np
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(111,projection='3d')

'''
fichier = open("/home/colette/Project_Monge_Problem/p_0.txt","r")
fichier2 = open("/home/colette/Project_Monge_Problem/p_0bis.txt","a")
for line in fichier:
	line = line.replace('[','')
	line = line.replace(']','')
	fichier2.write(line)
fichier.close()

fichier = open("/home/colette/Project_Monge_Problem/p_1.txt","r")
fichier2 = open("/home/colette/Project_Monge_Problem/p_1bis.txt","a")
for line in fichier:
	line = line.replace('[','')
	line = line.replace(']','')
	fichier2.write(line)
fichier.close()
'''		

p_0 = np.loadtxt('/home/colette/Project_Monge_Problem/p_0.txt')
N = len(p_0)
print(N)

x = [[i for i in range(N)] for j in range(N)]
x = np.reshape(x, N*N)
y = [[j for i in range(N)] for j in range(N)]
y = np.reshape(y, N*N)
p_0 = np.reshape(p_0, N*N)
ax.plot(x,y,p_0, '-b')

p_1 = np.loadtxt('/home/colette/Project_Monge_Problem/p_1.txt')

N = len(p_1)
print(N)

x = [[i for i in range(N)] for j in range(N)]
x = np.reshape(x, N*N)
y = [[j for i in range(N)] for j in range(N)]
y = np.reshape(y, N*N)
p_1 = np.reshape(p_1, N*N)
ax.plot(x,y,p_1, '-r')



ax.axis('equal')   # ajout
plt.show()
