load "Case.rb"

# DEPRECATED
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

    attr_reader :valeur

    include Comparable
    private_class_method :new

    def Ile.creer(posX, posY, nbLien, grille)
        new(posX, posY, nbLien, grille)
    end

    def initialize(posX, posY, nbLien, grille)
        super(posX, posY, grille)
        @valeur = nbLien
        @nbPont = 0

    end

    def getValeur()
        return @valeur
    end

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
      if(@valeur != ile.valeur)
          return @valeur <=> ile.valeur
      end
      return 0
    end


    #Cette méthode permet de retourner un voisin dans une direction
    #
    #@param direction La direction dans laquelle on cherche le voisin
    def getVoisin(direction)

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



    #Cette méthode permet de retourner un voisin dans une direction
    #
    #@param direction La direction dans laquelle on cherche le voisin
    def getVoisinDisponible(direction)

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

      indiceAddX = indiceX
      indiceAddY = indiceY

      until(@grille.sortLimite?(@posX + indiceX, @posY + indiceY) || @grille.getCase(@posX + indiceX, @posY + indiceY).estIle?())
        if(@grille.getCase(@posX + indiceX, @posY + indiceY).estPont?())
          if(@grille.getCase(@posX + indiceX, @posY + indiceY).direction == Pont::HORIZONTAL && (direction == Ile::HAUT || direction == Ile::BAS))
            raise("Le voisin n'est pas disponible")
          elsif(@grille.getCase(@posX + indiceX, @posY + indiceY).direction == Pont::VERTICAL && (direction == Ile::GAUCHE || direction == Ile::DROITE))
            raise("Le voisin n'est pas disponible")
          end
        end
        indiceX += indiceAddX
        indiceY += indiceAddY
      end
      posX = @posX + indiceX
      posY = @posY + indiceY

      if(@grille.sortLimite?(posX, posY))

        raise("Cette ile n'a pas de voisins dans cette direction")

      else

        return @grille.getCase(posX, posY)

      end

    end

    def aVoisinDisponible?(direction)
      begin
        return getVoisinDisponible(direction).estIle?()
      rescue => e
        puts e.message()
        return false
      end
    end

    def estIle?()

      return true

    end

end
