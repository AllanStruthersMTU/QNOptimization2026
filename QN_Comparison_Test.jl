# QN_Comparison_Test.jl

# Import required modules
using LinearAlgebra
using Printf
include("NonlinearOptimizationTestFunctions.jl")  # Assuming this file is available for importing

# Define the test functions and their true values
functions = [
    ("Ackley", ackley_function),
    ("Rosenbrock", rosenbrock_function),
    ("Dixon-Price", dixon_price_function)
]

# Gradient methods to test
methods = [SR1, DFP, BFGS, PSB, Newton]

# Starting point and dimension
n = 10
x0 = fill(0.5, n)

# Function to compute convergence rates
function test_methods()
    results = []

    for (name, func) in functions
        for method in methods
            # Call the method with its specific options
            rate = compute_convergence_rate(method, func, x0)
            push!(results, (name, method, rate))
        end
    end

    return results
end

# Function to format and print results
function print_results(results)
    println("Function, Method, Convergence Rate")
    for (name, method, rate) in results
        println("$name, $method, $rate")
    end
end

# Execute the tests and print results
results = test_methods()
print_results(results)