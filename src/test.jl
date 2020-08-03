import Random.rand, PyPlot

function main()
    L::Vector{Int64} = [0 for ind = 1:1000]
    for ind = 1:10000000
        r = rand()
        indice::Int64 = Int64(ceil(1000*r))
        L[indice]+=1
    end
    return L
end

function affichage(L::Vector{Int64})
    PyPlot.plot([ind for ind = 1:length(L)], L, "k-")
    PyPlot.ylim(0, 30000)
    PyPlot.show()
end
