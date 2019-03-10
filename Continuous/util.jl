module util

using LinearAlgebra, Statistics

export meshgrid, genSinusoid, genGabor
function meshgrid(vx::AbstractVector{T}, vy::AbstractVector{T}) where T
    m, n = length(vy), length(vx)
    vx = reshape(vx, 1, n)
    vy = reshape(vy, m, 1)
    (repeat(vx, m, 1), repeat(vy, 1, n))
end

function genSinusoid(sz, A, theta, sf, rho)
    radius = Int32.(round.(sz ./ 2))
    x,y = meshgrid(-radius[1]:radius[1]+1,
                    -radius[2]:radius[2]+1)

    omega = (cos(deg2rad(theta)),
     sin(deg2rad(theta)))
    stims = A * cos.(omega[1]*sf*x .+ omega[2]*sf*y .+ rho)
    return stims
end

function genGabor(sz, theta, K)
    radius = Int32.(round.(sz ./ 2))
    x,y = meshgrid(-radius[1]:radius[1]+1,
                    -radius[2]:radius[2]+1)

    omega = [cos(deg2rad(theta)),
     sin(deg2rad(theta))]

    x1 = x .* cos(deg2rad(theta)) .+ y .* sin(deg2rad(theta))
    y1 = -x .* sin(deg2rad(theta)) .+ y .* sin(deg2rad(theta))

    gauss = omega .^2 ./ (4pi * K^2) .* exp( .- omega.^2 ./ 8K.^2 * 4(x1.^2 .+ y1.^2))
    sinusoid = cos.(omega .* x1) .* exp(K^2 / 2)
    gabor = gauss * sinusoid
    return gabor
end
end
