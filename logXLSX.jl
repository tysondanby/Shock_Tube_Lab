using XLSX
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