using Plots
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
maxtime = ts[end] - (posmaxtime-xd)/Si
println()
println()
println("Position for maximum time in driven gas: $posmaxtime"*"m from the driver end.")
println("The time that this region experiences the desired flow is $maxtime"*"s.")

blue = RGB(0,0.1,0.7)
lightblue = RGB(0.6,0.7,1.0)
purple = RGB(0.4,0,0.4)
red = RGB(0.8,0,0)
expansioncolors = []
for i = 1:1:nexpansions
    if (i == 1) || (i == nexpansions)
        push!(expansioncolors,blue)
    else
        push!(expansioncolors,lightblue)
    end
end

xtplot = plot(ts,[expansionposs... xshocks xcss],c = [expansioncolors... red purple], rot = 90,xflip = true,ymirror=true,legend = false,xlims = (0,ts[end]),ylims =(0,xend+.03),size = (150,600))
xtplot