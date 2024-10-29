#GIVENS (from experiment) -----------------
p1i = -12.45
p4i = 26.68
T1i = 16.5
T4i = 23.0
Patm = 12.68
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

#CODE PARAMETERS --------------------------
#x-t Plot
nexpansions = 50
tstep = 5e-5
#Design study
gasoptions = ["air" "O2" "He"]
tempoptions = [280.0 400.0]
#END CODE PARAMETERS ----------------------




using  DelimitedFiles
#convert to K and Pa
p1i = 6894.75729*(p1i+Patm)
p4i = 6894.75729*(p4i+Patm)
T1i = T1i + 273.15
T4i = T4i + 273.15

datos = readdlm("data.tsv", '\t', Float64, '\n')

timevec = datos[:,1]
p1vec = datos[:,2]
p2vec = datos[:,3]
p3vec = datos[:,4]
