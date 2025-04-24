using DifferentialEquations
using BenchmarkTools
using Plots

function BantonDynamics!(dq, q, P, t)

    # Extract variables
    y1, y2, y3, y4, y5, y6  = q

    #Extract Parameters
    m1, m2, L, g = P

    #Create mass matrix
    mass = [1, 0, 0, 0, 0, 0; 0, m1 + m2, 0, 0, 0, -m2*L*s; 0, 0, 1, 0, 0, 0;0, 0, 0, m1 + m2, 0, m2*L*c; 0, 0, 0, 0, 1, 0; 0, -L*s, 0, L*c, 0, L2]

    #Create the right handside
    f = [q[2]; m2*L*q[6]^2*cos(q[5]); q[4]; m2*L*q[6]^2*sin(q[5])-(m1+m2)*g; q[6]; -g*L*cos(q[5])]

    #Compute the derivative
    dq = A\f
    nothing
end
prob = ODEProblem(BantonDynamics!, [0, 4, 1, 20, -pi / 2, 2], (0.0, 4), [0.1, 0.1, 1, 9.8])
sol = solve(prob)
print(sol)

# Save the plot
savefig("plot3.png")
println("Plot saved as plot.png")