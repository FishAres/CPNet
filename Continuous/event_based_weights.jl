using LinearAlgebra, Statistics, Plots
using ImageFiltering, Images

const height = 100
const width = 100 # canvas dimensions
const box_height = 10
const box_width = 10

canvas = zeros(height, width)
function draw_box(x, y)
    canvas = zeros(height, width)
    canvas[mod.(x:x+box_height, height).+1, mod.(y:y+box_width, width).+1] .= 1
    return canvas
end

x,y = 25, 50
canvas = draw_box(x,y);
canvas2 = draw_box(x-1, y-1);
imgl = imfilter(canvas2-canvas, Kernel.LoG((3,4)));
heatmap(imgl)

RF_size = (10,10)
RF_overlap = 0.2
# differences are linearly commutative
img2 = imfilter(canvas2-canvas, Kernel.LoG(3.2))
heatmap(img2)

function RF(x, y, RF_size, canvas; filter_type=Kernel.LoG(RF_size[1]/2))
    rf_rad = Int32.(RF_size ./ 2)
    rf = canvas[x-rf_rad[1]:x+rf_rad[1], y-rf_rad[2]:y+rf_rad[2]]
    rf = imfilter(rf, filter_type)
    return rf
end
