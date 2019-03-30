using LinearAlgebra, Statistics, Plots

function draw_box(x, y)
    canvas = zeros(height, width)
    canvas[mod.(x:x+box_height, height).+1, mod.(y:y+box_width, width).+1] .= 1
    return canvas
end
function meshgrid(vx::AbstractVector{T}, vy::AbstractVector{T}) where T
    m, n = length(vy), length(vx)
    vx = reshape(vx, 1, n)
    vy = reshape(vy, m, 1)
    (repeat(vx, m, 1), repeat(vy, 1, n))
end

function genSinusoid(sz, theta, sf; rho=0.0)
    radius = Int32.(round.(sz ./ 2))
    x,y = meshgrid(-radius[1]:radius[1]-1,
                    -radius[2]:radius[2]-1)

    omega = (cos(deg2rad(theta)),
     sin(deg2rad(theta)))
    stims = cos.(omega[1]*sf*x .+ omega[2]*sf*y .+ rho)
    return stims
end

function gaussian_2d(sz, sd; offset=(0.0, 0.0))
    radius = Int32.(round.(sz ./2))
    center_ = (radius[1] + offset[1], radius[2] + offset[2])
    x = repeat(collect(1:2radius[1]), 1, 2)
    # x = repeat(collect(-radius[1]:radius[1]-1), 1,2);
    exp_ = exp.(-((x[:,1] .- center_[1] ).^2 .+ (x[:,2] .- center_[2])'.^2) ./ (2(2sd^2))) ;
    exp_[findall(exp_ .<= 1e-6)] .= 0.0
    return exp_ ./ sum(exp_)
end

function genGabor(sz, theta, sf, sd; phase=0.0, offset=(0.0, 0.0))
    sine_array = genSinusoid(sz, theta, sf; rho=phase)
    mask = gaussian_2d(sz, sd; offset=offset) #.- gaussian_2d(sz, 3sd/2; offset=offset)
     gabor = mask .* sine_array
    return gabor
end

function norm_(X)
    mn = mean(X)
    std_ = std(X)
    return (X .- mn) ./ std_
end
