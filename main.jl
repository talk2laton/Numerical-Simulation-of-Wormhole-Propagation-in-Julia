using Pkg
Pkg.add("BenchmarkTools")

using DifferentialEquations
using BenchmarkTools
using Plots

function rober!(du, u, p, t)
    y₁, y₂, y₃ = u
    k₁, k₂, k₃ = p
    du[1] = -k₁ * y₁ + k₃ * y₂ * y₃
    du[2] = k₁ * y₁ - k₂ * y₂^2 - k₃ * y₂ * y₃
    du[3] = k₂ * y₂^2
    nothing
end
prob = ODEProblem(rober!, [1.0, 0.0, 0.0], (0.0, 4e6), [0.04, 3e7, 1e4])
elapsed_time = @elapsed sol = solve(prob, reltol = 1e-3, abstol = 1e-10, alg_hints=[:stiff])
println("Elapsed time: $elapsed_time seconds")
plot(sol, tspan = (1e-6, 4e6), xscale = :log10)

# Save the plot
savefig("plot2.png")
println("Plot saved as plot.png")