


load "Case.rb"

#Cette classe représente les ponts du Hashi
class Pont < Case

    #Ces constantes représentent les direction que peut prendre un pont
    NULLE = 0
    HORIZONTAL = 1
    VERTICAL = 2



    #Cette constante représente le nombre maximum de ligne pour un pont
    MAX_LIGNE = 2



    include Comparable

    #@valeur => Valeur du pont
    attr_reader :valeur

    #@direction => Direction du pont (NULLE, HORIZONTAL, VERTICAL)
    attr_reader :direction


    attr_accessor :surbrillance



    private_class_method :new

    #Ce constructeur permett de créer un nouveau pont
    #@param posY La position sur l'axe des abscisse
    #@param posY La position sur l'axe des ordonnées
    #@param grille La grille sur laquelle se trouve le pont
    def Pont.creer(posX, posY, grille)

        new(posX, posY, grille)

    end

    #:nodoc:
    def initialize(posX, posY, grille)

        super(posX, posY, grille)

        @valeur = 0

        @direction = NULLE


    end
    #:doc:


    #Cette méthode permet de comparer des ponts entre-eux
    def <=>(autre)

        if(@direction != autre.direction)

            return @direction <=> autre.direction

        end

        if(@valeur != autre.valeur)

            return @valeur <=> autre.valeur

        end

        return 0

    end

    #Cette méthode permet d'afficher le pont dans un terminal
    def to_s

        if(@direction == HORIZONTAL) 

            if(@valeur == 1) 

                return "| - "

            elsif(@valeur == 2) 

                return "| = "

            end

        elsif(@direction == VERTICAL) 

            if(@valeur == 1) 

                return "| ' "

            elsif(@valeur == 2)

                return "| \" "

            end

        end

        return "|   "

    end


    #Cette méthode permet de modifier la valeur du pont
    private def modifValeur(direction, valeur)

        if(@direction != NULLE)

            #On modifie la valeur du pont si la direection donné est la bonne
            if(@direction == direction)

                @valeur = (@valeur + valeur) % (MAX_LIGNE + 1)

                if(@valeur == 0) 

                    @direction = NULLE

                end

                return true

            end

            return false

        #On crée un nouveau pont
        elsif(@direction == NULLE)

            @direction = direction
            @valeur = valeur

            return true

        end

    end

    #Cette méthode permet d'augmenter la valeur du pont <br>
    #Si le pont que l'on augmente avait 2 trait alors le pont disparait
    def augmenteValeur(direction)

        return modifValeur(direction , 1)
        
    end

    #Cette méthode permet de diminuer la valeur du pont <br>
    def diminueValeur(direction)

        return modifValeur(direction , MAX_LIGNE)
        
    end

end

