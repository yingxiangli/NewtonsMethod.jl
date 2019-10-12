using NewtonsMethod
using Test



@testset "NewtonsMethod.jl" begin

  f(x) = (x - 1) ^ 3
  f_prime(x) = 3 * (x - 1) ^ 2
  root = 1

  # root
  x_0 = 0.5
  @test root ≈ fixedpointmap(f, f_prime, x_0).value #test with first method (f, f', x_0)
  @test root ≈ fixedpointmap(f, x_0).value #test with second method (f, x_0)

  # maxiter
  maxiter_test = 5
  @test_broken root ≈ fixedpointmap(f, f_prime, x_0, maxiter = maxiter_test).value #test with first method (f, f', x_0)
  @test_broken root ≈ fixedpointmap(f, x_0, maxiter = maxiter_test).value #test with second method (f, x_0)

  # tolerance
  tolerance_test = 1E-3
  @test_broken root ≈ fixedpointmap(f, f_prime, x_0, tolerance = tolerance_test).value #test with first method (f, f', x_0)
  @test_broken root ≈ fixedpointmap(f, x_0, tolerance = tolerance_test).value #test with second method (f, x_0)

  # BigFloat
  @test root ≈ fixedpointmap(f, f_prime, BigFloat(0.5)).value #test with first method (f, f', x_0)
  @test root ≈ fixedpointmap(f, BigFloat(0.5)).value #test with second method (f, x_0)

  # Non-convergence
  f_new(x) = x^2 + 1
  f_prime_new(x) = 2*x
  @test nothing == fixedpointmap(f_new, f_prime_new, x_0) #test with first method (f, f', x_0)
  @test nothing == fixedpointmap(f_new, x_0) #test with second method (f, x_0)
end
