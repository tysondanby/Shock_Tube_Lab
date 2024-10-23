using Plots, DelimitedFiles

datos = readdlm("data.tsv", '\t', Float64, '\n')

timevec = datos[1,:]
p1vec = datos[2,:]
p2vec = datos[3,:]
p3vec = datos[4,:]

