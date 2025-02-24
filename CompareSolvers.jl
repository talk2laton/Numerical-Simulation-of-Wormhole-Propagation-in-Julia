using DifferentialEquations
using Plots

# Define the differential equation
function f!(du, u, p, t)
    du[1] = u[2]
    du[2] = -u[1]
end

# Initial conditions and time span
u0 = [1.0, 0.0]
tspan = (0.0, 10.0)

# Define the problem
prob = ODEProblem(f!, u0, tspan)

# Solve using different algorithms
sol_tsit5 = solve(prob, Tsit5(), reltol=1e-6, abstol=1e-6)
sol_dp5 = solve(prob, DP5(), reltol=1e-6, abstol=1e-6)
sol_ck5 = solve(prob, CK5(), reltol=1e-6, abstol=1e-6)
sol_rkf45 = solve(prob, RKF45(), reltol=1e-6, abstol=1e-6)

# Plot the solutions
plot(sol_tsit5, label="Tsit5")
plot!(sol_dp5, label="DP5")
plot!(sol_ck5, label="CashKarp")
plot!(sol_rkf45, label="RKF45")
xlabel!("Time")
ylabel!("u(t)")
title!("Comparison of ODE Solvers")