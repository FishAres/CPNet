using LinearAlgebra, Statistics, Plots
using ImageFiltering, Images
using RecursiveArrayTools
include("util.jl")
include("receptive_fields.jl")

const height = 100
const width = 100 # canvas dimension
const box_height = 10
const box_width = 10

RF_size = 4
m, n = height, width
rf_rad = Int32.(round.(RF_size ./ 2))
centers = [rf_rad+1:RF_size:m-rf_rad  rf_rad+1:RF_size:n-rf_rad]
f(x,y, or_) = [mean(RF2(centers[k,1]+1,centers[j,2]+1, RF_size, draw_box(x,y), or_; phase=3pi/2)) for k in 1:size(centers,1),
 j in 1:size(centers,1)]

x0, y0 = 40, 10
act = [f(x0,y, 45) for y in y0:100];
VA = convert(Array, VectorOfArray(act))
heatmap(VA[:,:,70])

resp(x, t; tau=0.5) = x.*exp.(-x./(t./tau));
