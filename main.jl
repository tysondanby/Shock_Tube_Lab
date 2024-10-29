using Plots, XLSX

include("data.jl")#extract experimental data
include("tools.jl")
include("prelimcalcs.jl")#Calc props in regions 1 and 4
include("equations.jl")#Equations from text
include("regions2and3.jl")#Calc expected values for regions 2 & 3
include("region5.jl")#Calc expected values for region 5

Vexpansionfront = a4*-1.0
Vexpansiontail = v3 - a3
Vcs = (1-rho1/rho2)*Si

XLSX.openxlsx("out/Tables.xlsx", mode="w") do xf
    table1 = xf[1]
    XLSX.rename!(table1, "Table 1")
    XLSX.addsheet!(xf, "Table 2")
    table2 = xf[2]
    #dd a row
    table1["A1"] = ["Zone" "T (K)" "P (kPa)" "V (m/s)" "a (m/s)" "rho (kg/m^3)"]
    #adds a column
    table1["A2", dim=1] = collect(1:5)
    table1["B2", dim=1] = [T1, T2, T3, T4, T5]
    table1["C2", dim=1] = [p1, p2, p3, p4, p5]
    table1["D2", dim=1] = [v1, v2, v3, v4, v5]
    table1["E2", dim=1] = [a1, a2, a3, a4, a5]
    table1["F2", dim=1] = [rho1, rho2, rho3, rho4, rho5]

    table2["A1"] = ["Quantity" "S_I" "M_I" "S_R" "M_R" "V_cs" "V_expansion"] #Front expansion wave velocity
    table2["A2"] = ["value" Si Mi Sr Mr Vcs Vexpansionfront]
end
println("Excell printed")

nexpansions = 5
tstep = 0.0001
#initialize
ts = [0.0]
expansionposs = []
expansionvs = collect(Vexpansionfront:((Vexpansiontail-Vexpansionfront)/nexpansions):Vexpansiontail)
expansionreflected = []
for i = 1:1:nexpansions
    push!(expansionposs, [xd])
    push!(expansionreflected, false)
end
xcss = [xd]
xshocks = [xd]
shockreflected = false
shockaheadcs = true

#println(Si)
#println(Sr)
#println(Vexpansionfront)
#println(Vexpansiontail)

while shockaheadcs
    #println("Simulation time:")
    #println(ts[end])
    push!(ts,ts[end]+tstep)
    for i = 1:1:nexpansions
        if expansionreflected[i] == false
            push!(expansionposs[i], expansionposs[i][end] + expansionvs[i]*tstep)
            if expansionposs[i][end] <= 0.0#check for reflection
                expansionreflected[i] = true
                expansionposs[i][end] = -expansionposs[i][end]
            end
        else
            push!(expansionposs[i], expansionposs[i][end] - expansionvs[i]*tstep)
        end
    end
    if shockreflected == false
        push!(xshocks, xshocks[end] + Si*tstep)
        if xshocks[end] >= xend#check for reflection
            global shockreflected = true
            xshocks[end] = xend - (xshocks[end] - xend)
        end
    else
        push!(xshocks, xshocks[end] + Sr*tstep)
    end
    push!(xcss, xcss[end] + Vcs*tstep)
    if xcss[end] > xshocks[end]
        global shockaheadcs = false
    end
end

posmaxtime = xcss[end]
maxtime = ts[end] - posmaxtime/Si
println()
println()
println("Position for maximum time in driven gas: $posmaxtime m fromthe driver end.")
println("The time that this region experiences the desired flow is $maxtime s.")

gasoptions = ["air" "O2" "He"]
tempoptions = [280.0 400.0]

maxpressureratio = 1.0
maxdrivergas = ["air"]
maxdrivengas = ["air"]
maxdrivertemp = [280.0]
maxdrivertemp = [400.0]
for i = 1:1:length(gasoptions)
    for j = 1:1:length(tempoptions)
        for k = 1:1:length(gasoptions)
            for l = 1:1:length(tempoptions)
                drivengas = gasoptions[i]
                drivergas = gasoptions[k]
                driventemp = tempoptions[j]
                drivertemp = tempoptions[l]
                equation5_36(x) = eq5_36_general(p2_div_p1,drivengas,drivergas,driventemp,drivertemp)
                #=
                testpts = collect(0:0.01:10)
                values = @. equation5_36(testpts) 
                global debugplot = plot(testpts,values)
                # =#
                pressureratio = solver(equation5_36,1.01)#,p4/p1)#step2
                if pressureratio > maxpressureratio
                    global maxpressureratio = pressureratio
                    global maxdrivergas = drivergas
                    global maxdrivengas = drivengas
                    global maxdrivertemp = drivertemp
                    global maxdriventemp = driventemp
                end
                println("Through the loop")
            end
        end
    end
end

gamma1, R1 = gasprops(maxdrivengas)
a_1 = sqrt(gamma1*R1*maxdriventemp)

M2_max = eq5_35_general(maxpressureratio,gamma1, a_1)/eq5_37_general(maxpressureratio,gamma1, a_1)
println()
println()
println("Maximum mach number of $M2_max achieved with")
println(maxdrivengas*" at $maxdriventemp as the driven gas and")
println(maxdrivergas*" at $maxdrivertemp as the driver gas.")