function gasprops(gasname)
    if gasname == "air"
        return gamma,R
    elseif gasname == "O2"
        return gamma,RO2
    else
        return gammaHe,RHe
    end
end

function bisectionsolver(f,ub,lb)
    zero_enough = 1e-8
    upperguess = deepcopy(ub)
    lowerguess = deepcopy(lb)
    root = (ub + lb)/2
    while abs(f(root)) > zero_enough
        if sign(root) == sign(upperguess)
            upperguess = root
        else
            lowerguess = root
        end
        root = (upperguess + lowerguess)/2
    end
    return root
end

function old_solver(f,start)
    zero_enough = 1e-8
    step = 1e-5
    root = start
    value = f(root)
    while abs(f(root)) > zero_enough
        println(root)
        println(abs(f(root)))
        root = root+step*abs(value)
        value = f(root)
    end
    return root
end

function solver(f,start)
    zero_enough = 1e-9
    dx = 1e-8
    underrelaxation = 0.1
    root = start
    while abs(f(root)) > zero_enough
        #println(root)
        #println(f(root))
        dydx = (f(root+dx) - f(root-dx))/(2*dx)
        root = root - underrelaxation*f(root)/dydx
        if abs(root) > 1e3
            error("Divergent behavior detected")
        end
    end
    return root
end