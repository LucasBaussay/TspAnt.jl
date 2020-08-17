# VrpAnt

[![Build Status](https://travis-ci.com/LucasBaussay/VrpAnt.jl.svg?branch=master)](https://travis-ci.com/LucasBaussay/VrpAnt.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/LucasBaussay/VrpAnt.jl?svg=true)](https://ci.appveyor.com/project/LucasBaussay/VrpAnt-jl)
[![Coverage](https://codecov.io/gh/LucasBaussay/VrpAnt.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/LucasBaussay/VrpAnt.jl)
[![Coverage](https://coveralls.io/repos/github/LucasBaussay/VrpAnt.jl/badge.svg?branch=master)](https://coveralls.io/github/LucasBaussay/VrpAnt.jl?branch=master)

### Hey Jules !

You need first to add the package by taping in a julia console

```
julia> ]
pkg> add https://github.com/LucasBaussay/VrpAnt.jl
julia> using VrpAnt
```

Now you can create your Random map with 25 cities and optimize it :

```
julia> map = VrpAnt.Map(25)
julia> model = VrpAnt.Model(map)
julia> Vrp.optimize!(model)
julia> Vrp.display(model)
```
