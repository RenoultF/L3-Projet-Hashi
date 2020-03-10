
require "active_record"


class Case

    attr_reader :posX
    attr_reader :posY
    attr_reader :grille


    private_class_method :new


    def Case.generer(posX, posY, grille)
        new(posX, posY, grille)
    end

    def initialize(posX, posY, grille)
        @posX = posX
        @posY = posY
        @grille = grille
    end

    def affiche()
    end

    def afficheTerminal()
      print " "
    end

    def equals(autre)
    end


    def to_s
      " "
    end

    def estIle?()

      return false

    end

    def estPont?()

      return false

    end
end
