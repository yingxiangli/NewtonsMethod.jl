module NewtonsMethod

using LinearAlgebra
using ForwardDiff

function newtonroot(f, f_prime; x_0, tolerance = 1E-7, maxiter = 1000)
    # setup the algorithm
    x_old = x_0
    normdiff = Inf
    iter = 1
    g(x) = x .- f(x) ./ f_prime(x)
    while normdiff > tolerance && iter <= maxiter
        x_new = g(x_old)
        normdiff = norm(x_new - x_old)
        if normdiff > tolerance && iter > maxiter
            println("non-convergence ")
            return
        end
        x_old = x_new
        iter = iter + 1
    end
    return (value = x_old, normdiff = normdiff, iter = iter)
end


function newtonroot(f; x_0, tolerance = 1E-7, maxiter = 1000)
    # setup the algorithm
    x_old = x_0
    normdiff = Inf
    iter = 1
    D(f) = x -> ForwardDiff.derivative(f, x)
    f_prime = D(f)
    x_old, normdiff, iter = newtonroot(f, f_prime; x_0, tolerance = tolerance, maxiter = maxiter)
    return (value = x_old, normdiff = normdiff, iter = iter)
end

export newtonroot

end # module
