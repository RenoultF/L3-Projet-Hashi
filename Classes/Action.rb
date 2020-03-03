class Action
  #@pont
  attr:pont, false
  attr:grille, false
  attr:ajout, false
  
  #:nodoc:
  def initialize(pont, grille, ajout)
    @pont = pont
    @grille = grille
  end

  #:doc:

  ##
  #empile l'action dans la pile d'action de grille
  #@return : l'action empilée
  def empiler()
    grille.actions.push self
  end

  ##
  #dépile l'action de la pile d'action de grille
  #@return : l'action dépilée
  def depiler()
    grille.actions.pop self
  end

  def getCoord
    return pont.posX(), pont.posY()
  end
end
