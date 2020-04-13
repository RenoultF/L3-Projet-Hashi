

load "../Core/Case.rb"


##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe représente les iles de la grille
#
#Hérite de Case
class Ile < Case

  #Cette constante représente l'une des directions dans laquelle peut se trouver un voisin
  HAUT = 0

  #Cette constante représente l'une des directions dans laquelle peut se trouver un voisin
  DROITE = 1

  #Cette constante représente l'une des directions dans laquelle peut se trouver un voisin
  BAS = 2

  #Cette constante représente l'une des directions dans laquelle peut se trouver un voisin
  GAUCHE = 3

  #Cette constante représente l'ensemble des directions dans laquelle peut se trouver un voisin
  DIRECTIONS = [HAUT, DROITE, BAS, GAUCHE]

  #@valeur => Le nombre de lien que doit possèder l'ile pour être valide
  attr_reader :valeur

  #@dernier => true si l'ile est la derniere ile séléctionnée
  attr_accessor :dernier

  include Comparable
  private_class_method :new

  ##
  #Ce constructeur permet de créer une nouvelle ile
  #param::
  # * posX La position en abscisse
  # * posY La position en ordonnée
  # * nbLien Le nombre de lien que doit possèder l'ile pour être valide
  # * grille La grille sur laquelle se trouve l'ile
  def Ile.creer(posX, posY, nbLien, grille)
      new(posX, posY, nbLien, grille)
  end

  #:nodoc:
  def initialize(posX, posY, nbLien, grille)
      super(posX, posY, grille)
      @valeur = nbLien
      @nbPont = [0, 0, 0, 0]
      @dernier = false
  end
  #:doc:

  ##
  #Cette méthode permet de recuperer le nombre de lien nécéssaire pour être valide
  #return::
  # * Le nombre de lien nécéssaire pour être valide
  def getValeur()
      return @valeur
  end

  ##
  #Cette méthode permet de recuperer le nombre de lien actuel
  #return::
  # * Le nombre de lien actuel
  def getNombrePont()
    return @nbPont[HAUT] + @nbPont[DROITE] + @nbPont[BAS] + @nbPont[GAUCHE]
  end

  ##
  #Cette méthode permet d'ajouter un pont entre cette ile et une autre
  #param::
  # * ile L'autre ile
  def ajouteNombrePont(ile)
    for direction in DIRECTIONS
      if(aVoisin?(direction))
        if(getVoisin(direction) == ile)
          puts "Ajoute : Direction : " + direction.to_s()
          @nbPont[direction] += 1
          @nbPont[direction] %= (Pont::MAX_LIGNE + 1)
        end
      end
    end
  end

  ##
  #Cette méthode permet de retirer un pont entre cette ile et une autre
  #param::
  # * ile L'autre ile
  def retireNombrePont(ile)
    for direction in DIRECTIONS
      if(aVoisin?(direction))
        if(getVoisin(direction) == ile)
          puts "Retire : Direction : " + direction.to_s()
          @nbPont[direction] += Pont::MAX_LIGNE
          @nbPont[direction] %= (Pont::MAX_LIGNE + 1)
        end
      end
    end
  end

  ##
  #Cette méthode permet d'appeler clickOnIle de la grille dans laquelle se trouve l'ile
  def clickOn()

    @grille.clickOnIle(self)

  end

  ##
  #Cette méthode permet de savoir si cette ile est la dernière ile séléctionné
  #return::
  # * true Si l'ile est la dernière séléctionné
  # * false Sinon
  def estDernierIle()

    return @dernier

  end



  ##
  #Cette méthode permet de savoir si l'ile est connécté à autant de pont que son objectif
  #return::
  # * true Si l'ile est connécté à autant de pont que son objectif
  # * false Sinon
  def estValide?()
      return getNombrePont() == getValeur()
  end


  ##
  #Cette méthode permet de savoir combien il reste de pont à connécter pour que l'ile soit valide
  #return::
  # * Combien il reste de pont à connécter pour que l'ile soit valide
  def getCapaciteResiduelle()
    return getValeur() - getNombrePont()
  end

  ##
  #Cette méthode permet de savoir le nombre de ponts qui peuvent être connecté à l'ile
  #return::
  # * Le nombre de ponts qui peuvent être connecté à l'ile
  def getNombreCheminDisponible()
    ret = 0
    for direction in DIRECTIONS
      if(aVoisinDisponible?(direction))
        voisin = getVoisin(direction)
        ret += [2 - @grille.valeurPont(voisin, self), voisin.getCapaciteResiduelle()].min()
      end
    end
    return ret
  end

  ##
  #Cette méthode permet d'afficher l'ile dans un terminal
  def to_s()
      return getCapaciteResiduelle().to_s()
  end

  ##
  #Cette méthode permet d'afficher les infos utiles de l'ile
  def afficheInfo()
      return @valeur, @posX, @posY
  end

  ##
  #Cette méthode permet de connaitre le nombre de directions dans laquelle on peut ajouter un pont
  #return::
  # * Le nombre de directions dans laquelle on peut ajouter un pont
  def getNombreDirectionConstructible()
    ret = 0
    for direction in DIRECTIONS
      if(aVoisinDisponible?(direction))
        if(@grille.valeurPont(self, getVoisin(direction)) != Pont::MAX_LIGNE && getVoisin(direction).getCapaciteResiduelle > 0)
          ret += 1
        end
      end
    end
    return ret
  end

  ##
  #Cette méthode permet de connaitre le nombre de direction dans laquelle un voisin est disponible
  #return::
  # * Le nombre de direction dans laquelle un voisin est disponible
  def getNombreDirectionDisponible()
    ret = 0
    for direction in DIRECTIONS
      if(aVoisinDisponible?(direction))
        ret += 1
      end
    end
    return ret
  end

  ##
  #Cette méthode permet de comparer des iles entre-elles
  #param::
  # * autre L'autre ile à comparer
  #return::
  # * 0 si les iles sont égales
  # * un nombre négatif si la première ile est inférieure à la deuxième
  # * un nombre positif si la première ile est supérieure à la deuxième
  def <=>(autre)

    return 1 if(!autre.estIle?())
    return @valeur <=> autre.valeur if(@valeur != autre.valeur)
    return @posX <=> autre.posX if(@posX != autre.posX)
    return @posY <=> autre.posY if(@posY != autre.posY)
    return 0

  end

  ##
  #Cette méthode permet de connaitre un voisin dans une direction
  #param::
  # * direction La direction dans laquelle on cherche le voisin
  #return::
  # * Le voisin dans cette direction s'il existe
  # * raiseException Sinon
  def getVoisin(direction)
    indiceX, indiceY = getIncrementDirection(direction)
    indiceAddX = indiceX
    indiceAddY = indiceY
    until(@grille.sortLimite?(@posX + indiceX, @posY + indiceY) || @grille.getCase(@posX + indiceX, @posY + indiceY).estIle?())
      indiceX += indiceAddX
      indiceY += indiceAddY
    end
    posX = @posX + indiceX
    posY = @posY + indiceY
    if(@grille.sortLimite?(posX, posY))
      raise("Cette ile n'a pas de voisins dans cette direction : " + direction.to_s())
    else
      return @grille.getCase(posX, posY)
    end
  end

  ##
  #Cette méthode permet de savoir si l'ile a un voisin dans une direction
  #param::
  # * direction La direction dans laquelle on cherche le voisin
  #return::
  # * true Si l'ile a un voisin dans cette direction
  # * false Sinon
  def aVoisin?(direction)
    begin
      return getVoisin(direction).estIle?()
    rescue => e
      puts e.message()
      return false
    end
  end

  private def getIncrementDirection(direction)
    if(direction == Ile::HAUT)
      indiceX = -1
      indiceY = 0
    elsif (direction == Ile::BAS)
      indiceX = 1
      indiceY = 0
    elsif (direction == Ile::GAUCHE)
      indiceX = 0
      indiceY = -1
    elsif (direction == Ile::DROITE)
      indiceX = 0
      indiceY = 1
    else
      raise("La direction n'est pas bonne")
    end
    return indiceX, indiceY
  end


  ##
  #Cette méthode permet de savoir si l'ile a un voisin disponible dans une direction (s'il n'a pas de pont qui les sépares)
  #param::
  # * direction La direction dans laquelle on cherche le voisin
  #return::
  # * true Si l'ile a un voisin disponible dans cette direction
  # * false Sinon
  def aVoisinDisponible?(direction)
    begin
      ile2 = self.getVoisin(direction)
      puts "Allo ?" + ile2.to_s()
      return @grille.routeDisponible?(self, ile2)
    rescue => e
      puts e.message()
      return false
    end
  end

  ##
  #Cette méthode retourne vrai
  #return::
  # * true
  def estIle?()
    return true
  end

  ##
  #Cette méthode permet de remettre à zéro l'ile
  def raz
    @nbPont = [0, 0, 0, 0]
    @dernier = false
  end

end
