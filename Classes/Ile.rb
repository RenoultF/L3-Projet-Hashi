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

    ##
    #Retourne la valeur de l'ile
    #@return : la valeur de l'ile
    def getValeur()
        return @valeur
    end

    ##
    #Verifie si le nombre de pont vérifie la valeur de l'ile
    #@return : vrai ou faux
    def estValide?()
        if @nbPont == @valeur
            return true
        else
            return false
        end
    end

    def affiche()
    end

    ##
    #Affichage de l'ile dans un terminal
    def afficheTerminal()
        return "(#{@valeur})"
    end

    ##
    #Methode Permettant de comparer deux iles entre elles
    #@param : la deuxieme ile a comparer
    #@return : 0 si la valeur des deux iles sont egales
    #un nombre négatif si la premiere ile est inférieur a la deuxieme
    #un nombre positif si la premiere ile est superieur a la deuxieme
    def <=>(ile)
        if(ile.instance_of? Ile)
            if(@valeur != ile.valeur)
                return @valeur <=> ile.valeur
            end
        end
        return 0
    end


    def to_s
      "#{@valeur}"
    end

end
