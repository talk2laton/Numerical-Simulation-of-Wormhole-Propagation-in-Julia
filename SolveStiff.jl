using DifferentialEquations
using BenchmarkTools
using Plots

function VanderPol!(du, u, p, t)
    y₁, y₂ = u
    du[1] =  y₂
    du[2] = p * ((1 - y₁^2) * y₂ - y₁)
    nothing
end
prob = ODEProblem(VanderPol!, [2.0, 0.0], (0.0, 6.3), 1e5)
sol = solve(prob, alg_hints=[:stiff])
plot(sol, tspan = (0.0, 6.3), ylim = (-10, 10))

# Save the plot
savefig("plot3.png")
println("Plot saved as plot.png")