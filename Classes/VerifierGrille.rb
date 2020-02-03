load("Aide.rb")
class VerifierGrille < Aide
    ##
    #marque les ponts à mettre en surbrillance
    #@param [grille] la grille du jeu
    #@param [solution] la grille solution
    #@return [boolean] true si il n'y a pass d'erreur, false sinon
    def demandeAide(grille, solution)
        res = true
        grille.mat.each do |caseG|
            solution.mat.each do |caseS|
                if(!caseG.equals(caseS) && caseG.valeur > 0)
                    res = false
                    caseG.surbrillance = true
                end
            end
        end
        return res
    end
end