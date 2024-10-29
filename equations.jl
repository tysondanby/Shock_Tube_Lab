function eq5_36(p2overp1)
    num = (gamma-1)*(a1/a4)*(p2overp1-1)
    den = sqrt(2*gamma)*sqrt(2*gamma+(gamma+1)*(p2overp1-1))
    ex = -2*gamma/(gamma-1)
    return p2overp1*(1-num/den)^ex - (p4/p1)
end

function eq5_32(p2overp1)
    return a1*sqrt(((gamma+1)/(2*gamma))*p2overp1+((gamma-1)/(2*gamma)))
end

function eq5_35(p2overp1)
    num = (2*gamma)/(gamma+1)
    den = p2overp1 + ((gamma-1)/(gamma+1))
    return (a1/gamma)*(p2overp1-1)*sqrt(num/den)
end

function eq5_37(p2overp1)
    num = ((gamma-1)/(gamma+1))*p2overp1 + 1
    den = ((gamma-1)/(gamma+1))*(1/p2overp1) + 1
    return num/den
end

function eq5_34(p2overp1)
    num = ((gamma+1)/(gamma-1))*p2overp1 + 1
    den = ((gamma+1)/(gamma-1))+ p2overp1
    return num/den
end

function eq5_38(p2overp1)
    num = p2overp1
    den = p4/p1
    ex = (gamma-1)/gamma
    return (num/den)^ex
end

function eq5_30_modified(pressure3,pressure4)
    return (pressure3/pressure4)^(-gamma)#rho3/rho4
end

function eq5_24(plow,phigh)#p1,p2 as written
    num = phigh*(3*gamma-1)/(gamma+1) - plow*(gamma-1)/(gamma+1)
    den = plow + phigh*(gamma-1)/(gamma+1)
    return (num/den)*phigh#Reflected shock presure
end

function eq5_36_general(p2overp1,gas1,gas4,T1,T4)
    gamma1, R1 = gasprops(gas1)
    gamma4, R4 = gasprops(gas4)
    #println(gamma1)
    #println(gamma4)
    #println(R1)
    #println(R4)
    a_1 = sqrt(gamma1*R1*T1)
    a_4 = sqrt(gamma4*R4*T4)
    num = (gamma4-1)*(a_1/a_4)*(p2overp1-1)
    den = sqrt(2*gamma1)*sqrt(2*gamma1+(gamma1+1)*(p2overp1-1))
    ex = -2*gamma4/(gamma4-1)
    return p2overp1*(1-num/den)^ex - (p4/p1)
end

function eq5_35_general(p2overp1,gamma1, a_1)
    num = (2*gamma1)/(gamma1+1)
    den = p2overp1 + ((gamma1-1)/(gamma1+1))
    return (a_1/gamma1)*(p2overp1-1)*sqrt(num/den)
end

function eq5_37_general(p2overp1,gamma1,a_1)
    num = ((gamma1-1)/(gamma1+1))*p2overp1 + 1
    den = ((gamma1-1)/(gamma1+1))*(1/p2overp1) + 1
    return sqrt(num/den)*a_1#returns a2
end

