
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


load "../Core/Case.rb"

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

    include Comparable
    private_class_method :new

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
        @nbPont = 0
    end
    #:doc:

    #Cette méthode permet de recuperer le nombre de lien nécéssaire pour être valide
    #
    #@return Le nombre de lien nécéssaire pour être valide
    def getValeur()
        return @valeur
    end

    #Cette méthode permet de savoir si une ile est connécté à autant de pont que son objectif
    #
    #@return true si l'ile est connécté à autant de pont que son objectif, false sinon
    def estValide?()
        if @nbPont == @valeur
            return true
        else
            return false
        end
    end

    def to_s()
        return "#{@valeur.to_s}"
    end

    def afficheInfo()
        return @valeur, @posX, @posY
    end

    def afficheTerminal()
        return "(#{@valeur})"
    end

    def <=>(ile)
      return @valeur <=> ile.valeur
    end


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



    #Cette méthode permet de retourner un voisin dans une direction
    #
    #@param direction La direction dans laquelle on cherche le voisin
    def aVoisinDisponible?(direction)
      begin
        ile2 = self.getVoisin(direction)
        ret = @grille.routeDisponible?(self, ile2)
        puts "La ax"
        return ret
      rescue => e
        puts "Pas de chance :" + e.message()
        return false
      end
    end


    def estIle?()
      return true
    end

end
