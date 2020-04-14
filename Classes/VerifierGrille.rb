load("Aide.rb")
# DEPRECATED
class VerifierGrille < Aide
    attr:bTetard, false
    ##
    #marque les ponts à mettre en surbrillance
    #@param [grille] la grille du jeu
    #@param [solution] la grille solution
    #@return [boolean] true si il n'y a pass d'erreur, false sinon
    def demandeAide(grille, solution)
        res = true
        grille.mat.each do |caseG|
          caseS = solution.mat[caseG.posX][caseG.posY]
          if(caseG.instance_of?(Pont) && caseS != caseG)
            res = false
            if(caseG.valeur > 0)
              caseG.surbrillance = true
            end
          end
        end
        if(res)
          bTetard = true
        else
          bTetard = false
        end
        return res
    end
    ##
    #verifie si l'ile est reliée correctement
    #@param [Ile] Ile à verifier
    #@param [Grille] La grille solution
    #@return [boolean] vrai si bien reliée
    def verifierIle(ile, solution)
      return ile.grille.mat[ile.posX][ile.posY+1] == (solution.mat[ile.posX][ile.posY+1]) && ile.grille.mat[ile.posX][ile.posY-1] == (solution.mat[ile.posX][ile.posY-1]) && ile.grille.mat[ile.posX+1][ile.posY] == (solution.mat[ile.posX+1][ile.posY]) && ile.grille.mat[ile.posX-1][ile.posY] == (solution.mat[ile.posX-1][ile.posY])
    end
    ##
    #verifie que l'ile est reliée aux bonnes iles, indépendamment du fait que ce soit des doubles pont ou pas.
    #@param [Ile] Ile à verifier
    #@param [Grille] La grille solution
    #@return [boolean] vrai si bien reliée
    def estAPeuPresBienReliee(ile, solution)
      return ile.grille.mat[ile.posX][ile.posY+1] == (solution.mat[ile.posX][ile.posY+1]) && ile.grille.mat[ile.posX][ile.posY-1] == (solution.mat[ile.posX][ile.posY-1]) && ile.grille.mat[ile.posX+1][ile.posY] == (solution.mat[ile.posX+1][ile.posY]) && ile.grille.mat[ile.posX-1][ile.posY] == (solution.mat[ile.posX-1][ile.posY])
    end
end
