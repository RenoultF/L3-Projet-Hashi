






class Couleur


  attr_reader :couleur

  include Comparable

  def initialize(couleur)

    modifCouleur(couleur)

  end


  def modifCouleur(couleur)

    @couleur = couleur
    return self

  end

  def rouge
    return @couleur[0]
  end

  def vert
    return @couleur[1]
  end

  def bleu
    return @couleur[2]
  end


  def <=>(autre)

    return @couleur <=> autre.couleur

  end

  BLANC =   Couleur.new([1, 1, 1])
  NOIR =    Couleur.new([0, 0, 0])
  JAUNE =   Couleur.new([1, 1, 0])
  CYAN =    Couleur.new([0, 1, 1])
  MAGENTA = Couleur.new([1, 0, 1])
  BLEU =    Couleur.new([0, 0, 1])
  VERT =    Couleur.new([0, 1, 0])
  ROUGE =   Couleur.new([1, 0, 0])

end
