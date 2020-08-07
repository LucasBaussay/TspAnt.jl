using VrpAnt
using Test

@testset "VrpAnt.jl" begin
    m = Map(12)

    @testset "Creation of the Map" begin
        @test length(m.cities) == 12

        @testset "Solution" begin
            @test m.solution.length == Inf
            @test m.solution.path == Vector{City}[]
            @test m.solution.state == InProgress()
            @test m.solution.usedSpace == 0
            @test m.solution.usedTime == 0
        end
        @test m.ways == Dict{VrpAnt.CityIndex,Dict{VrpAnt.CityIndex,VrpAnt.Way}}()
        @test length(m.listModification) == 12
        @test length(m.transitions) == 12

    end
    optimize!(m)

    @testset "After the optimize function" begin
        
    end
end
