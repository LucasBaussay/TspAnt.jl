import Random

abstract type MapModification end

struct AddCity <: MapModification
    city::City
end

struct DeleteCity <: MapModification
    city::City
end

mutable struct Map

    cities::Vector{City}

    transitions::Dict{City, Union{Vector{CityIndex}, Nothing}}
    ways::Dict{CityIndex, Dict{CityIndex, Way}}

    listModification::Vector{MapModification}

    solution::Solution

end

struct RandomCreation end

function Map()
    return Map(Vector{City}(), Dict{City, Vector{CityIndex}}(), Dict{CityIndex, Dict{CityIndex, Way}}(), Vector{MapModification}(),  Solution())
end

#Is it better for Space complexity ? Time Complexity ? to not recrate space memory every time

# function Map(nbrVille)
#     return Map(Vector{City}(undef, nbrVille), Vector{Vector{Float64}}( undef, nbrVille ))
# end

# TODO : Find how to use the macro correctly

# TODO :
# - Precise  which city are connected to each other ! To make a perfect map
# - Give ptentially a set distance to each other city, like a Dict{City, distance}
#   Then if there isn't that : the distance are calculate by x^2 + y^2
#   else : the fixed one are used

function city!(map::Map, x::Float64, y::Float64, transition::Union{Vector{Int64}, Nothing} = nothing,  pheroInit::Float64=2.)

    nbrVille::Int64 = length(map.cities)
    city::City = City(x, y, nbrVille+=1)

    if transition != nothing
        transition = [CityIndex(index) for index in transition]
    end
    #I'm there right now !

    # ways::Dict{City, Way} = Dict(map.cities[ind] => Way(distance(city, map.cities[ind]), pheroInit) for ind = 1:nbrVille-1)


    push!(map.cities, city)
    push!(map.transitions, city => transition)

    push!(map.listModification, AddCity(city))

    return city
end

#TODO : Find how tu use the macro correctly

function Map(nbrVille::Int64, ::RandomCreation, borneX::Int64 = 50, borneY::Int64 = 50)
    m = Map()
    for ind = 1:nbrVille
        cityX = borneX*rand()
        cityY = borneY*rand()
        city!(m, cityX, cityY)
    end
    return m
end

function updatePhero!(map::Map, p::Float64)
    for dictWays in collect(values(map.ways))
        for way in collect(values(dictWays))
            way.pheromone *= p
        end
    end
    return map
end

function createWays!(map::Map, pheroInit::Float64)
    for change in map.listModification
        city = change.city
        nextCitiesIndex = map.transitions[city]
        if nextCitiesIndex != nothing
            push!(map.ways, city.index => Dict(cityIndex => Way(distance(city, map.cities[cityIndex.value]), pheroInit) for cityIndex in (map(nextCityIndex-> nextCityIndex != city.index, nextCitiesIndex))))
        else
            listCities = map.cities[:]
            deleteat!(listCities, city.index.value)
            ways = Dict(nextCity.index => Way(distance(city, nextCity), pheroInit) for nextCity in listCities)
            push!(map.ways, city.index => ways)
        end
    end
    # return map
end
