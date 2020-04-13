

require "../Core/Aide.rb"


##
#Cette classe permet de donner de l'aide pour résoudre une grille
class VerifierGrille < Aide

  ##
  #Ce constructeur permet de créer une nouvelle aide
  #param :
  # * grille La grille sur laquelle on va donner des aides
  def VerifierGrille.creer(grille)
    new(grille)
  end

  #:nodoc:
  def initialize(grille)
    super(grille)
  end
  #:doc:


  ##
  #L'aide apporté ici est de marquer tous les ponts dont la valeur est supérieur à la solution
  #Par exemple si dans la solution un pont était un pont simple et que le joueur a placé un pont double, alors se pont sera marquer et affiché en tant que tel
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
