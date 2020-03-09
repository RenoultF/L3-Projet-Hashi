load "Case.rb"

class Ile < Case
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
        return " #{@valeur.to_s} "
    end

    def afficheTerminal()
        return "(#{@valeur})"
    end

    def <=>(ile)
        if(ile.instance_of? Ile)
            if(@valeur != ile.valeur)
                return @valeur <=> ile.valeur
            end
        end
        return 0
    end

end
