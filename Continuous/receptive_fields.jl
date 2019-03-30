using LinearAlgebra, Statistics

include("util.jl")
function RF2(x, y, RF_size, canvas, theta; sf=0.8, sd=0.2*RF_size, phase=0.0, offset=(0.0, 0.0))
    canv = copy(canvas)
    rf_rad = Int32.(RF_size ./ 2)
    rf = genGabor((RF_size, RF_size), theta, sf, sd; phase=phase, offset=offset)
    canv[x-rf_rad[1]:x+rf_rad[1]-1, y-rf_rad[1]:y+rf_rad[1]-1] =
    canv[x-rf_rad[1]:x+rf_rad[1]-1, y-rf_rad[1]:y+rf_rad[1]-1] .* norm_(rf)
    return canv
end
