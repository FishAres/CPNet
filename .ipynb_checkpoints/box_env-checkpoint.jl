using LinearAlgebra, Statistics, Plots

const height = 50
const width = 50 # canvas dimensions
const box_height = 10
const box_width = 10

canvas = zeros(height, width)
function draw_box(x, y, i, j)
    canvas = zeros(height, width)
    canvas[mod.(x+i:x+box_height+i, height).+1, mod.(y+j:y+box_width+j, width).+1] .= 1
    return canvas
end

(x,y) = rand(1:height, 2)
j = 0
for i in 1:20
    global canvas
    canvas = draw_box(x, y, i, j)
    p = heatmap(canvas)
    display(p)
    sleep(0.1)
end

using Flux
n_channels = 1
in_canvas = reshape(canvas, (height, width, n_channels, 1))
in_model = Chain(
    x -> reshape(x, (2500, 1)),
    Dense(2500, 128, relu)
)

r_model = Chain(
    LSTM(128, 64)
)

out_model = Chain(
    Dense(64, 512, relu),
    Dense(512, 2500),
    x -> reshape(x, (50, 50, 1, 1))
)

tot_model = Chain(
    in_model,
    r_model,
    out_model
)

loss(x,y) = Flux.mse(tot_model(x), y)
