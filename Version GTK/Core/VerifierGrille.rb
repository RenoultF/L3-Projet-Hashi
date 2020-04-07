



class VerifierGrille < Aide

  def VerifierGrille.creer(grille)
    new(grille)
  end

  def initialize(grille)
    super(grille)
  end


  def aider()
    for i in (0..@grille.tailleX - 1)
      for j in (0..@grille.tailleY - 1)
        cGrille = @grille.getCase(i, j)
        cSolution = @grille.getCaseSolution(i, j)
        puts cGrille, cSolution
        if(cGrille.estPont?())
          if(cGrille.direction != Pont::NULLE)
            if(cGrille.direction != cSolution.direction || cGrille.valeur > cSolution.valeur)
              cGrille.marquer()
            end
          end
        end
      end
    end
  end
end
