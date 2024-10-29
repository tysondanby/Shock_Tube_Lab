using  DelimitedFiles

#GIVENS (from experiment) -----------------
p1i = 3236.7
p4i = 322948.6
T1i = 293.0
T4i = 293.0
#left to right as drawn in handout positions
xd = 3.1
xplo = 8.79
xend = 14.77
#END GIVENS (from experiment) -------------

#CONSTANTS --------------------------------
R = 287.0 #j/kgK
gamma = 1.4
Cp = 1006 #J/(kg*K) 
gammaHe = 1.6666667
RHe = 2077.1
RO2 = 259.84
#END CONSTANTS ----------------------------

#convert to K and Pa
#p1i = 6894.75729*p1i#TODO
#p4i = 6894.75729*p4i
#T1i = T1i + 273.15
#T4i = T4i + 273.15

datos = readdlm("data.tsv", '\t', Float64, '\n')

timevec = datos[1,:]
p1vec = datos[2,:]
p2vec = datos[3,:]
p3vec = datos[4,:]
