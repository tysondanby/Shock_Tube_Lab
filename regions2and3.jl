using Roots
#Follow proceedure outlined in text pg 180 (steps 2-8, 1 was done in prelimcalcs.jl)

p2_div_p1 = solver(eq5_36,2.0)#,p4/p1)#step2
p2 = p2_div_p1*p1
Si = eq5_32(p2_div_p1)#step3
v2 = eq5_35(p2_div_p1)#step4
T2 = eq5_37(p2_div_p1)*T1 #step5
rho2 = eq5_34(p2_div_p1)*rho1 #step6
T3 = eq5_38(p2_div_p1)*T4 #step7
rho3_div_rho4 = eq5_30_modified(p2,p4)#step8

#Shock speed, Ms, and properties of region 2
#Si =
a2 = sqrt(gamma*R*T2)
Mi = Si/a1 #TODO: make sure this is defined with the right a
#p2 = 
#T2 = 
#rho2 =
#v2 =

#calc properties in region 3
p3 = p2
#T3 = 
rho3 = p3/(R*T3)
v3 = v2
a3 = sqrt(gamma*R*T3)