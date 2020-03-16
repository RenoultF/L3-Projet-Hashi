
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


#Cette class représente les cases de notre grille
class Case

  #@posX => La position en abscisse de la case
  attr_reader :posX

  #@posX => La position en ordonnée de la case
  attr_reader :posY

  #@posX => La grille sur laquelle se trouve la case
  attr_reader :grille

  include Comparable

  private_class_method :new

  #Ce constructeur permet de creer une nouvelle case
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


  #Cette méthode permet de comparer deux cases
  #
  #@return 0 car on ne peut pas différencier deux cases
  def <=>(casee)
    return 0
  end


  #Cette méthode permet d'afficher la case
  def to_s
    " "
  end

  #Cette méthode permet de savoir si la case est une ile
  #
  #@return true si la case est une ile, false sinon
  def estIle?()
    return false
  end

  #Cette méthode permet de savoir si la case est un pont
  #
  #@return true si la case est un pont, false sinon
  def estPont?()
    return false
  end
end
