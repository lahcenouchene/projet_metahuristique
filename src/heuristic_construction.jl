function heuristic_construction_v2(C::Vector{Int}, A::Matrix{Int})
    m, n = size(A)
    
    # Étape 1 : Calculer la densité basée sur la répétition de 1
    repetitions = vec(sum(A, dims=1))  # Nombre de répétitions de 1 pour chaque variable
    densities = C ./ repetitions  # Diviser le coût par le nombre de répétitions
    
    # Étape 2 : Trier les indices par densité décroissante
    sorted_indices = sortperm(densities, rev=true)
    
    # Étape 3 : Construire la solution faisable
    x = zeros(Int, n)  # Initialiser la solution avec des zéros
    covered_constraints = zeros(Int, m)  # Contraintes couvertes
    
    for j in sorted_indices
        if all(covered_constraints .+ A[:, j] .<= 1)  # Vérifier la faisabilité
            x[j] = 1  # Ajouter l'ensemble à la solution
            covered_constraints += A[:, j]  # Mettre à jour les contraintes couvertes
        end
    end
    
    # Calculer la valeur de la fonction objectif
    z = dot(C, x)
    
    return z, x
end
