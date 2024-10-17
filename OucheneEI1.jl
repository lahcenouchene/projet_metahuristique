# =========================================================================== #
# Compliant julia 1.x

# Using the following packages
using JuMP, GLPK
using LinearAlgebra

include("src/loadSPP.jl")
include("src/setSPP.jl")
include("src/getfname.jl")
# Ajouter la fonction heuristique
include("src/heuristic_construction.jl")
include("src/local_search.jl")  # Inclure la recherche locale
include("src/experiment1.jl")  # Inclure le fichier des expérimentations

# Appeler l'exécution des instances
run_experiment1()

# =========================================================================== #

# Loading a SPP instance
function resoudreSPP(fname)
    

println("\nLoading...")

C, A = loadSPP(fname)
@show C
@show A

# Running heuristic construction
# println("\nRunning heuristic construction...")
z_heuristic, x_heuristic = heuristic_construction(C, A)  # Capturer z et x
# println("Heuristic solution: ", x_heuristic)
# println("Heuristic objective value z: ", z_heuristic)  # Afficher z

# Solving a SPP instance with GLPK
# println("\nSolving...")
# solverSelected = GLPK.Optimizer
# spp = setSPP(C, A)

# set_optimizer(spp, solverSelected)
# optimize!(spp)

# Displaying the results
# println("z = ", objective_value(spp))
# print("x = "); println(value.(spp[:x]))

# =========================================================================== #

# Collecting the names of instances to solve
println("\nCollecting...")
target = "dat"
fnames = getfname(target)

println("\nThat's all folks !")

end