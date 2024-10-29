p5 = eq5_24(p1,p2)
Sr = -1*(-v2 - a2^2/(v2+Si)) #TODO: check if sign correct
#post-reflection (if it matters).
To2 = T2 + (Sr+v2)^2/(2*Cp)
To5 = To2
T5 = To5 - (Sr)^2/(2*Cp)

#Reflected shock speed, Mr, and properties of region 5
#Sr = 
#p5 =
a5 = sqrt(gamma*R*T5)
Mr = abs(Sr/a5) #TODO: make sure this is defined with the right a
#T5 = 
rho5 = p5/(R*T5)
v5 = 0.0