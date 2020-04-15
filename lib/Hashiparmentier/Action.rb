# DEPRECATED
class Action
  #@pont
  attr:pont, false
  attr:grille, false
  attr:ajout, false

  #:nodoc:
  def initialize(pont, grille, ajout)
    @pont = pont
    @grille = grille
    @ajout = ajout
  end

  #:doc:

  ##
  #empile l'action dans la pile d'action de grille
  #@return : l'action empilée
  def empiler
    @grille.actions.push self
  end

  ##
  #dépile l'action de la pile d'action de grille
  #@return : l'action dépilée
  def depiler
    @grille.actions.pop self
  end

  ##
  #retourne un tableau avec les variable d'action
  #@return : tab[ajout(0:supr/1:ajout) , posX, posY, direction(1: horizontal / 2: vertical)]
  def getCoord
    return @ajout, @pont.posX(), @pont.posY(), @pont.direction()
  end
end
