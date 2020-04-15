

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe représente les cases de notre grille
class Case

  #@posX => La position en abscisse de la case
  attr_reader :posX

  #@posY => La position en ordonnée de la case
  attr_reader :posY

  #@grille => La grille sur laquelle se trouve la case
  attr_reader :grille

  include Comparable

  private_class_method :new

  ##
  #Ce constructeur permet de créer une nouvelle case
  #param::
  # * posX La position en abscisse de la case
  # * posY La position en ordonnée de la case
  # * grille La grille dans laquelle se trouve la case
  def Case.creer(posX, posY, grille)
      new(posX, posY, grille)
  end

  #:nodoc:
  def initialize(posX, posY, grille)
      @posX = posX
      @posY = posY
      @grille = grille
  end
  #:doc:

  ##
  #Cette méthode permet de simuler un "clic" sur la case
  def clickOn()

  end

  ##
  #Cette méthode permet de comparer deux cases
  #param::
  # * autre L'autre case
  #return::
  # * 0 Si l'autre case n'est ni une ile ni un pont
  # * 1 Sinon
  def <=>(autre)
    if(autre.estIle?() || autre.estPont?())
      return 1
    end
    return 0
  end

  ##
  #Cette méthode permet d'afficher la case
  def to_s
    " "
  end

  ##
  #Cette méthode permet de savoir si la case est une ile
  #return::
  # * true Si la case est une ile
  # * false Sinon
  def estIle?()
    return false
  end

  ##
  #Cette méthode permet de savoir si la case est un pont
  #return::
  # * true Si la case est un pont
  # * false Sinon
  def estPont?()
    return false
  end

  ##
  #Cette méthode permet de remettre à zéro la case
  def raz()

  end

end
