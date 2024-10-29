include("data.jl")#extract experimental data
include("tools.jl")#gas props and rootfinding
include("prelimcalcs.jl")#Calc props in regions 1 and 4
include("equations.jl")#Equations from text
include("regions2and3.jl")#Calc expected values for regions 2 & 3
include("region5.jl")#Calc expected values for region 5

Vexpansionfront = a4*-1.0
Vexpansiontail = v3 - a3
Vcs = (1-rho1/rho2)*Si

include("logXLSX.jl")#save tables to Excell
include("x-t_plot.jl")#makes the plot and calculates where maximum exposure to v2 is.
include("designstudy.jl")#Finds optimum combination of gas and temperature to maximize M2.

range = 180:350
fulldataplot = plot(timevec,[p1vec p2vec p3vec])
dataplot = plot(1000*timevec[range],[p2vec[range] p3vec[range]],labels = ["Plo" "Phi"],xlabel = "Time (ms)",ylabel = "Pressure (psig)", title = "Pressure vs Time")