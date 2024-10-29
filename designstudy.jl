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
                equation5_36(x) = eq5_36_general(x,drivengas,drivergas,driventemp,drivertemp)
                #=
                testpts = collect(0:0.01:10)
                values = @. equation5_36(testpts) 
                global debugplot = plot(testpts,values)
                # =#
                pressureratio = solver(equation5_36,1.01)#,p4/p1)#step2
                #println(equation5_36(2.0))
                if pressureratio > maxpressureratio
                    global maxpressureratio = pressureratio
                    global maxdrivergas = drivergas
                    global maxdrivengas = drivengas
                    global maxdrivertemp = drivertemp
                    global maxdriventemp = driventemp
                end
                #println("Through the loop")
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