# Attention changement de patrmaetre a vérifier sur tout les appels

mutable struct Ant

	way::Vector{City}
	lengthMade::Float64
	notWay::Vector{City}

end

function Ant(cities::Vector{City})

	ant = Ant(Vector{City}(), 0., cities[:])

	city = rand(cities)

	push!(ant.way, city)
	filter!(notCity -> notCity != city, ant.notWay)

	return ant

end


# Find how to empty ant.way
function empty!(ant::Ant, cities::Vector{City})

	firstCity::City = ant.way[1]
	ant.way = Vector{City}()
	push!(ant.way, firstCity)

	ant.lengthMade = 0.
	ant.notWay = filter(city -> city != firstCity, cities)

	return ant

end

function addCity!(ant::Ant, city::City, way::Way)

	push!(ant.way, city)
	ant.lengthMade += way.length
	filter!(notCity -> notCity != city, ant.notWay)

end

function calcTotal(city::City, nextCities::Vector{City}, map::Map, α::Real, β::Real)

	total::Float64 = 0.

	for nextCity in nextCities
		way = map.ways[city][nextCity]

		total += way.pheromone^α * way.length^(-β)
	end

	return total

end

function calcProba(ant::Ant, way::Way, total::Float64, α::Real, β::Real)
	return way.pheromone^α * way.length^(-β) / total
end

# TODO : Make that code clearer WITH SOME SUB FUNCTIONS
# Find why the sum(listProba) is not equal to 1. but sometimes 0.04 and other time 4.98
# This is a complete mess xD

function chooseCity(map::Map, ant::Ant, α::Real, β::Real)

	city::City = ant.way[length(ant.way)]
	# dictProba::Dict{City, Float64} = Dict{City, Float64}()

	ways::Dict{City, Way} = map.ways[city]
	total::Float64 = calcTotal(city, ant.notWay, map, α, β)

	# maxProba::Float64 = 0.
	# nextCity = ant.notWay[1]

	listProba = Vector{Float64}()
	sumProba = 0.

	indCity = 1

	# if city.index > nextCity.index
	# 	nextWay = map.ways[city][nextCity]
	# else
	# 	nextWay = map.ways[nextCity][city]
	# end

	for potentialCity in ant.notWay

		way = map.ways[city][potentialCity]
		proba = calcProba(ant, way, total, α, β)

		push!(listProba, proba)
	end

	rand = Random.rand()*sum(listProba)
	# print(sum(listProba), "\n")

	while rand > sumProba && indCity < length(ant.notWay)
		sumProba += listProba[indCity]
		indCity += 1
	end
	nextCity = ant.notWay[indCity]

	nextWay = map.ways[city][nextCity]

	return nextCity, nextWay

end

# TODO : Find how tu use the macro correctly

function round!(ant::Ant, map::Map, α::Real, β::Real)
	empty!(ant, map.cities)
	nbVille = length(map.cities)
	for ind = 1:nbVille-1
		nextCity, nextWay = chooseCity(map, ant, α, β)
		addCity!(ant, nextCity, nextWay)

	end
	firstCity = ant.way[1]
	lastCity = ant.way[length(ant.way)]

	way = map.ways[firstCity][lastCity]

	addCity!(ant, firstCity, way)
	return ant

end

function wayBack!(map::Map, ant::Ant, Q::Real)

	for idTown = 1:length(ant.way)-1
		city = ant.way[idTown]
		nextCity = ant.way[idTown+1]

		way = map.ways[city][nextCity]

		way.pheromone += Q/ant.lengthMade
	end
	# firstCity = ant.way[1]
	# lastCity = ant.way[length(ant.way)]
	#
	# if firstCity.index < lastCity.index
	# 	way = map.ways[firstCity][lastCity]
	# else
	# 	way = map.ways[lastCity][firstCity]
	# end
	#
	# way.pheromone += Q/ant.lengthMade

end

function searchBestAnt(antList::Vector{Ant})
	bestAnt::Ant = antList[1]
	for ant in antList
		if ant.lengthMade < bestAnt.lengthMade
			bestAnt = ant
		end
	end
	return bestAnt
end
