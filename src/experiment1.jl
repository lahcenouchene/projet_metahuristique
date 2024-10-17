# experiment1.jl

function run_experiment1()
    # Liste des fichiers d'instances à tester
    fnames = [
        "dat/didactic.dat",
        "dat/pb_100rnd0100.dat",
        "dat/pb_100rnd0600.dat",
        "dat/pb_100rnd0700.dat",
        "dat/pb_100rnd0800.dat",
        "dat/pb_100rnd1000.dat",
        "dat/pb_200rnd0100.dat",
        "dat/pb_500rnd0100.dat",
        "dat/pb_1000rnd0100.dat",
        "dat/pb_2000rnd0100.dat"
    ]
    
    # Pour chaque fichier dans la liste
    for fname in fnames
        println("\nLoading instance: $fname")
        
        # Charger les données du problème
        C, A = loadSPP(fname)

        # Exécuter l'heuristique initiale
        z_heuristic, x_heuristic = heuristic_construction_v2(C, A)
        # println("Heuristic solution: ", x_heuristic)
        println("Heuristic objective value z: ", z_heuristic)

        # Exécuter la recherche locale
        z_local, x_local = local_search_k1_exchange(C, A, x_heuristic)
        # println("Local search solution: ", x_local)
        println("Local search objective value z: ", z_local)


        # Exécuter la recherche locale 2-1
        z_local_k2, x_local_k2 = local_search_k2_exchange(C, A, x_heuristic)
        println("Local search 2-1 objective value z: ", z_local_k2)

        # Comparer avec le solveur exact (facultatif)
       # println("\nSolving with GLPK for comparison...")
       # solverSelected = GLPK.Optimizer
        # spp = setSPP(C, A)
        # set_optimizer(spp, solverSelected)
        # optimize!(spp)
        
        # Afficher les résultats du solveur
        # println("Optimal solution z = ", objective_value(spp))
        # print("x = "); println(value.(spp[:x]))
    end
end
