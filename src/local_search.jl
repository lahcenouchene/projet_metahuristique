function local_search_k1_exchange(C::Vector{Int}, A::Matrix{Int}, x::Vector{Int})
    m, n = size(A)
    initial_z = dot(C, x)  # Sauvegarder l'objectif initial de l'heuristique
    z = initial_z
    improved = true

    while improved
        improved = false
        best_z = z
        best_x = copy(x)

        # Parcourir tous les ensembles de la solution actuelle
        for j in 1:n
            if x[j] == 1  # Si l'ensemble j est dans la solution
                # Essayer de l'échanger avec un ensemble qui n'est pas dans la solution
                for k in 1:n
                    if x[k] == 0  # Si l'ensemble k n'est pas dans la solution
                        # Créer une nouvelle solution en échangeant j et k
                        temp_x = copy(x)
                        temp_x[j] = 0  # Retirer j
                        temp_x[k] = 1  # Ajouter k

                        # Vérifier la faisabilité
                        covered_constraints = A * temp_x
                        if all(covered_constraints .<= 1)  # Si la solution est faisable
                            temp_z = dot(C, temp_x)  # Calculer le nouveau z
                            if temp_z > best_z  # Si on a trouvé une meilleure solution
                                best_z = temp_z
                                best_x = copy(temp_x)
                                improved = true  # Il y a une amélioration
                            end
                        end
                    end
                end
            end
        end

        # Mettre à jour la solution si on a trouvé une meilleure
        if improved
            x = best_x
            z = best_z
        end
    end

    # Si la recherche locale n'a pas donné une meilleure solution, conserver la solution initiale
    if z < initial_z
        z = initial_z
        x = copy(x)
    end

    return z, x

end


# recherceh local 2-1-----------------------------------------------------------------------------------------

function local_search_k2_exchange(C::Vector{Int}, A::Matrix{Int}, x::Vector{Int})
    m, n = size(A)
    initial_z = dot(C, x)
    z = initial_z
    improved = true

    while improved
        improved = false
        best_z = z
        best_x = copy(x)

        # Essayer tous les échanges 2-1
        for j in 1:n
            if x[j] == 1  # Si l'ensemble j est dans la solution
                for k in 1:n
                    if x[k] == 1 && k != j  # Si l'ensemble k est aussi dans la solution
                        for l in 1:n
                            if x[l] == 0  # Si l'ensemble l n'est pas dans la solution
                                # Créer une nouvelle solution en échangeant j et k avec l
                                temp_x = copy(x)
                                temp_x[j] = 0  # Retirer j
                                temp_x[k] = 0  # Retirer k
                                temp_x[l] = 1  # Ajouter l

                                # Vérifier la faisabilité
                                covered_constraints = A * temp_x
                                if all(covered_constraints .<= 1)  # Si la solution est faisable
                                    temp_z = dot(C, temp_x)  # Calculer le nouveau z
                                    if temp_z > best_z  # Si on a trouvé une meilleure solution
                                        best_z = temp_z
                                        best_x = copy(temp_x)
                                        improved = true  # Il y a une amélioration
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        # Mettre à jour la solution si on a trouvé une meilleure
        if improved
            x = best_x
            z = best_z
        end
    end

    return z, x
end
