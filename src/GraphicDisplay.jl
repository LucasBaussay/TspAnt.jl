import PyPlot

function displayRoad(city1::City, city2::City)
    return [city1.x, city2.x], [city1.y, city2.y]
end

function display(map::Map)
    for city in map.cities
        PyPlot.plot(city.x, city.y, "k.")
    end
    path = map.solution.path
    for ind = 1:length(path)-1
        road = displayRoad(path[ind], path[ind+1])
        PyPlot.plot(road[1], road[2], "r-")
    end
end
