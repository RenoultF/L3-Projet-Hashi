
require "active_record"


class Case

    private_class_method :new
    attr_reader :posX
    attr_reader :posY
    attr_reader :grille

    def Case.generer(x,y,gril)
        new(x,y,gril)
    end

    def initialize(x,y,gril)
        @posX = x
        @posY = y
        @grille = gril
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
end
