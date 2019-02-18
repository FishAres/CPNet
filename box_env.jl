using LinearAlgebra, Statistics, Plots

const height = 200
const width = 200 # canvas dimensions
const box_height = 20
const box_width = 20

canvas = zeros(height, width)
function draw_box(x, y, i, j)
    canvas = zeros(height, width)
    canvas[mod.(x+i:x+box_height+i, height).+1, mod.(y+j:y+box_width+j, width).+1] .= 1
    return canvas
end

(x,y) = rand(1:200, 2)
j = 0
for i in 1:30
    global canvas
    canvas = draw_box(x, y, i, j)
    p = heatmap(canvas)
    display(p)
    sleep(0.1)
end

using Flux
n_channels = 1
in_layer = Conv((20, 20), 1=>10, stride=(2,2), pad=(1,1), relu)
in_canvas = reshape(canvas, (height, width, 1, 1))
