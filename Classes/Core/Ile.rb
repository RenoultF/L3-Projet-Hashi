
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


load "../Core/Case.rb"


##
#Cette classe représente les iles de la grille
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
    #
    #@param posX La position en abscisse
    #
    #@param posY La position en ordonnée
    #
    #@param nbLien Le nombre de lien que doit possèder l'ile pour être valide
    #
    #@param grille La grille sur laquelle se trouve l'ile
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
    #
    #@return Le nombre de lien nécéssaire pour être valide
    def getValeur()
        return @valeur
    end

    ##
    #Cette méthode permet de recuperer le nombre de lien actuel
    #
    #@return Le nombre de lien actuel
    def getNombrePont()
      return @nbPont[HAUT] + @nbPont[DROITE] + @nbPont[BAS] + @nbPont[GAUCHE]
    end

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


    def clickOn()

      @grille.clickOnIle(self)

    end

    def estDernierIle()

      return @dernier

    end



    ##
    #Cette méthode permet de savoir si l'ile est connécté à autant de pont que son objectif
    #
    #@return true si l'ile est connécté à autant de pont que son objectif, false sinon
    def estValide?()
        if getNombrePont() == getValeur()
            return true
        else
            return false
        end
    end


    def getCapaciteResiduelle()

      return getValeur() - getNombrePont()

    end

    def getNombreCheminDisponible()
      ret = 0
      for direction in DIRECTIONS
        if(aVoisinDisponible?(direction))
          voisin = getVoisin(direction)
          puts "Mon voisin : " + voisin.estIle?().to_s()
          puts "Val pont : " + (2 - @grille.valeurPont(voisin, self)).to_s
          puts "Cap voisin : " + voisin.getCapaciteResiduelle().to_s
          ret += [2 - @grille.valeurPont(voisin, self), voisin.getCapaciteResiduelle()].min()
        end
      end
      return ret
    end

    def to_s()
        return getCapaciteResiduelle().to_s()
    end

    def afficheInfo()
        return @valeur, @posX, @posY
    end

    #Retourne le nombre de voisins actuellement disponible qui ne sont pas rélié par deux ponts
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

    #Retourne le nombre de voisins actuellement disponible
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
    #
    #@param autre L'autre ile à comparer
    #
    #@return :
    #
    #0 si les iles sont égales
    #
    #un nombre négatif si la première ile est inférieure à la deuxième
    #
    #un nombre positif si la première ile est supérieure à la deuxième
    def <=>(autre)
      if(!autre.estIle?())
        return 1
      end
      if(@valeur != autre.valeur)
        return @valeur <=> autre.valeur
      end
      if(@posX != autre.posX)
        return @posX <=> autre.posX
      end
      if(@posY != autre.posY)
        return @posY <=> autre.posY
      end
      return 0
    end

    ##
    #Cette méthode permet de retourner un voisin dans une direction
    #
    #@param direction La direction dans laquelle on cherche le voisin
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
  #
  #@param direction La direction dans laquelle on cherche le voisin
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
    #
    #@param direction La direction dans laquelle on cherche le voisin
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


    def estIle?()
      return true
    end

    def raz
      @nbPont = [0, 0, 0, 0]
      @dernier = false
    end

end
