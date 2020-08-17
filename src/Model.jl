mutable struct Model

    map::Map
    solution::Solution

    ways::Dict{CityIndex, Dict{CityIndex, Way}}

end

function Model()
    return Model(Map(), Solution(), Dict{CityIndex, Dict{CityIndex, Way}}())
end

function Model(map::Map, pheroInit::Float64 = 1.)
    return Model(map, Solution(), createWays(map, pheroInit))
end

function Model(nbVille::Int64, borneX::Real = 50, borneY::Real = 50)
    map = Map(nbVille, borneX, borneY)
    return Model(map)
end
