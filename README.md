# VrpAnt

[![Build Status](https://travis-ci.com/LucasBaussay/VrpAnt.jl.svg?branch=master)](https://travis-ci.com/LucasBaussay/VrpAnt.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/LucasBaussay/VrpAnt.jl?svg=true)](https://ci.appveyor.com/project/LucasBaussay/VrpAnt-jl)
[![Coverage](https://codecov.io/gh/LucasBaussay/VrpAnt.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/LucasBaussay/VrpAnt.jl)
[![Coverage](https://coveralls.io/repos/github/LucasBaussay/VrpAnt.jl/badge.svg?branch=master)](https://coveralls.io/github/LucasBaussay/VrpAnt.jl?branch=master)

### Hey Jules !

So I've many problems above 11 cities I don't know why. I'll work on it but it should be ok just to test it now.

You need first to add the package by taping in a julia console

```
julia> ]
pkg> add https://github.com/LucasBaussay/VrpAnt
julia> using VrpAnt
```

Now you can create your Random map and optimize it :

```
julia> m = VrpAnt.Map(nbrVille::Int64)
julia> Vrp.optimize!(m)
julia> Vrp.display(m)
```
