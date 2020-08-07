module VrpAnt

import Base.empty, Random.rand

include("City.jl")
include("Way.jl")
include("Solution.jl")
include("Map.jl")
include("Ant.jl")

include("GraphicDisplay.jl")

# function empty!(antList::Vector{Ant})
#     antList = [empty!(ant) for ant in antList]
#     return antList
# end
#
# function init!(map::Map, antList::Vector{Ant})
#     return [init!(map, ant) for ant in antList]
# end
#
# function lap(map::Map, antList::Vector{Ant})
#     empty!(antList)
#     init!(map, antList)
#


# true if it has to stop, otherwise return false
function stopCondition!(map::Map, antList::Vector{Ant}, ind::Int64, stillSame::Int64, NCmax::Int64, stillSameMax::Int64)
    if ind > NCmax
        map.solution.state = NCEnding()
        return true
    elseif ind == 0
        return false
    else
        if stillSame >= stillSameMax
            map.solution.state = NoChangeEnding()
            return true
        elseif reduce( & , [ant.lengthMade ≈ antList[1].lengthMade for ant in antList])
            map.solution.state = AntEnding()
            return true
        else
            return false
        end
    end
end


function optimize!(map::Map, m::Union{Nothing, Int64} = nothing, p::Float64 = 0.5, α::Real = 3, β::Real = 1, Q::Real = 100, NCmax::Int64 = 5000, stillSameMax::Int64 = 50, pheroInit::Float64 = 1.)
    createWays!(map, pheroInit)
    m == nothing ? _optimize!(map, length(map.cities), p, α, β, Q, NCmax, stillSameMax) : _optimize!(map, m, p, α, β, Q, NCmax, stillSameMax)
    return map
end

#Change about the model !!!!!!!!!

function _optimize!(map::Map, m::Int64, p::Float64, α::Real, β::Real, Q::Real, NCmax::Int64, stillSameMax::Int64)
    antList::Vector{Ant} = [Ant(map.cities) for loop = 1:m]
    ind::Int64 = 0
    stillSame::Int64 = 0

    while !stopCondition!(map, antList, ind, NCmax, stillSame, stillSameMax)

        if ind != 0
            for ant in antList
                wayBack!(map, ant, Q)
            end
        end
        updatePhero!(map, p)
        for ant in antList
            round!(ant, map, α, β)
        end

        ind+=1
        stillSame = updateSolution!(map, stillSame, antList)
    end

    return map
end


function updateSolution!(map::Map, stillSame::Int64, antList::Vector{Ant})
    bestAnt::Ant = searchBestAnt(antList)

    if bestAnt.lengthMade < map.solution.length
        map.solution.path = bestAnt.way
        map.solution.length = bestAnt.lengthMade
        return 0
    else
        return stillSame+1
    end
end

export optimize!, Map, display

end  # module
