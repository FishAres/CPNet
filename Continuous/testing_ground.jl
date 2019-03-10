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
