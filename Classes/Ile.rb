load "Case.rb"

class Ile < Case



    #Cette constante représente l'une des directions dans laquelle peut se trouver un voisin
    HAUT = 0

    #Cette constante représente l'une des directions dans laquelle peut se trouver un voisin
    DROITE = 1

    #Cette constante représente l'une des directions dans laquelle peut se trouver un voisin
    BAS = 2

    #Cette constante représente l'une des directions dans laquelle peut se trouver un voisin
    GAUCHE = 3


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


    def getVoisin(direction)

      indice = 1

      if(direction == Ile::HAUT)
        until(@grille.sortLimite(@posX, @posY - indice) or @grille.getGrille()[@posX][@posY - indice].estIle?())
          indice += 1
        end
        posX = @posX
        posY = @posY - indice
      elsif(direction == Ile::BAS)
        until(@grille.sortLimite(@posX, @posY + indice) or @grille.getGrille()[@posX][@posY + indice].estIle?())
          indice += 1
        end
        posX = @posX
        posY = @posY + indice
      elsif(direction == Ile::GAUCHE)
        until(@grille.sortLimite(@posX - indice, @posY) or @grille.getGrille()[@posX - indice][@posY].estIle?())
          indice += 1
        end
        posX = @posX - indice
        posY = @posY
      elsif(direction == Ile::DROITE)
        until(@grille.sortLimite(@posX + indice, @posY) or @grille.getGrille()[@posX + indice][@posY].estIle?())
          indice += 1
        end
        posX = @posX + indice
        posY = @posY
      else
        raise("Cette ile n'a pas de voisins")
      end

      return @grille.getGrille()[posX][posY]

    end

    def aVoisin(direction)

      return getVoisin(direction).estIle?()

    end

    def estIle?()

      return true

    end

end
