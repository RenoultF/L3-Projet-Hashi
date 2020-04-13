

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe représente des couleurs
class Couleur

  #@couleur => La couleur représentée, tableau contenant trois valeurs [rouge, vert, bleu], avec rouge, vert et bleu des flottants compris entre 0 et 1
  attr_reader :couleur

  include Comparable

  ##
  #Ce constructeur permet de créer une nouvelle couleur
  #param::
  # * couleur La tableau qui représente la couleur
  def initialize(couleur)
    modifCouleur(couleur)
  end


  private def modifCouleur(couleur)
    @couleur = couleur
    return self
  end

  ##
  #Cette méthode permet de connaitre la composante rouge de la couleur
  #return::
  # * La composante rouge de la couleur
  def rouge
    return @couleur[0]
  end

  ##
  #Cette méthode permet de connaitre la composante verte de la couleur
  #return::
  # * La composante verte de la couleur
  def vert
    return @couleur[1]
  end

  ##
  #Cette méthode permet de connaitre la composante bleu de la couleur
  #return::
  # * La composante bleu de la couleur
  def bleu
    return @couleur[2]
  end

  ##
  #Cette méthode permet de comparer la couleur avec une autre
  #param::
  # * autre L'autre couleur
  #return::
  # * 0 Si les deux couleurs sont égales
  # un nombre positif si la couleur est supérieur à l'autre
  # un nombre négatif si la couleur est inférieur à l'autre
  def <=>(autre)

    return @couleur <=> autre.couleur

  end

  #La couleur blanc
  BLANC =   Couleur.new([1, 1, 1])

  #La couleur noir
  NOIR =    Couleur.new([0, 0, 0])

  #La couleur jaune
  JAUNE =   Couleur.new([1, 1, 0])

  #La couleur cyan
  CYAN =    Couleur.new([0, 1, 1])

  #La couleur magenta
  MAGENTA = Couleur.new([1, 0, 1])

  #La couleur bleu
  BLEU =    Couleur.new([0, 0, 1])

  #La couleur vert
  VERT =    Couleur.new([0, 1, 0])

  #La couleur rouge
  ROUGE =   Couleur.new([1, 0, 0])

end
