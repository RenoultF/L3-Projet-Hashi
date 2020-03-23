

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

load "../Core/Case.rb"

#Cette classe représente les ponts du Hashi
class Pont < Case

    #Cette constante représente l'une des directions que peut prendre un pont(Seulement quand valeur du pont = 0)
    NULLE = 0

    #Cette constante représente l'une des directions que peut prendre un pont(Pont horizontal)
    HORIZONTAL = 1

    #Cette constante représente l'une des directions que peut prendre un pont(Pont vertical)
    VERTICAL = 2



    #Cette constante représente le nombre maximum de ligne pour un pont
    MAX_LIGNE = 2


    include Comparable

    #@valeur => Valeur du pont(nombre de trait)
    attr_reader :valeur

    #@direction => Direction du pont (NULLE, HORIZONTAL, VERTICAL)
    attr_reader :direction

    #@surbrillance => Booléen pour l'affichage, si égal à true le pont sera affiché en surbrillance verte
    attr_accessor :surbrillance

    #@marque => Booléen pour l'affichage, si égal à true le pont sera affiché en surbrillance rouge
    attr_accessor :marque

    #:nodoc:
    def Pont.verifieDirection(direction)

      case(direction)

      when NULLE
        return true

      when HORIZONTAL
        return true

      when VERTICAL
        return true

      else
        return false

      end

    end
    #:doc:


    private_class_method :new

    #Ce constructeur permet de créer un nouveau pont
    #
    #@param posX La position sur l'axe des abscisse
    #
    #@param posY La position sur l'axe des ordonnées
    #
    #@param grille La grille sur laquelle se trouve le pont
    def Pont.creer(posX, posY, grille)

        Pont.construit(posX, posY, grille, NULLE, 0)

    end

    #Ce constructeur permet de créer un nouveau pont
    #
    #@param posX La position sur l'axe des abscisse
    #
    #@param posY La position sur l'axe des ordonnées
    #
    #@param grille La grille sur laquelle se trouve le pont
    #
    #@param direction La direction du pont
    #
    #@param valeur La taillee du pont
    def Pont.construit(posX, posY, grille, direction, valeur)

        if((Pont.verifieDirection(direction)))

          new(posX, posY, grille, direction, valeur)

        else

          new(posX, posY, grille, NULLE, 0)

        end

    end


    #:nodoc:
    def initialize(posX, posY, grille, direction, valeur)

        super(posX, posY, grille)
        @valeur = valeur
        @direction = direction
        @surbrillance = false
        @marque = false

    end
    #:doc:


    ##
    #Cette méthode permet de comparer des ponts entre-eux
    #
    #@param autre L'autre pont à comparer
    #
    #@return :
    #
    #0 si les ponts sont égaux
    #
    #un nombre négatif si le premier pont est inférieur au deuxième
    #
    #un nombre positif si le premier pont est supérieur au deuxième
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
    def to_s()
      ret = " "
      if(@surbrillance)
        ret = "P"
      end
      if(@direction == HORIZONTAL)
        if(@valeur == 1)
          ret = "-"
        elsif(@valeur == 2)
          ret = "="
        end
      elsif(@direction == VERTICAL)
        if(@valeur == 1)
          ret = "|"
        elsif(@valeur == 2)
          ret = "\""
        end
      end
      if(@marque)
        ret = "R"
      end
      return ret
    end


    #:nodoc:
    private def modifValeur(direction, valeur)
        demarquer()
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

    private def modifSurbrillance(direction, valeur)
      if(@direction != NULLE)
        #On modifie la valeur du pont si la direection donné est la bonne
        if(@direction == direction)
          @surbrillance = valeur
          return true
        end
        return false
        #On crée un nouveau pont
      elsif(@direction == NULLE)
        @surbrillance = valeur
        return true
      end
    end
    #:doc:


    #Cette méthode permet d'augmenter la valeur du pont
    #
    #@param direction La direction dans laquelle ont veut augmenter le pont
    #
    #Si le pont que l'on augmente avait 2 trait alors le pont disparait
    #
    #@return true si la valeur à été modifié, false sinon
    def augmenteValeur(direction)

        return modifValeur(direction, 1)

    end

    #Cette méthode permet de diminuer la valeur du pont
    #
    #@param direction La direction dans laquelle ont veut diminuer le pont
    #
    #Si le pont que l'on diminue n'avait pas de trait alors un pont à deux trait apparait
    #
    #@return true si la valeur à été modifié, false sinon
    def diminueValeur(direction)

        return modifValeur(direction, MAX_LIGNE)

    end



    #Cette méthode permet d'augmenter la valeur du pont
    #
    #@param direction La direction dans laquelle ont veut augmenter le pont
    #
    #Si le pont que l'on augmente avait 2 trait alors le pont disparait
    #
    #@return true si la valeur à été modifié, false sinon
    def metSurbrillance(direction)

        return modifSurbrillance(direction, true)

    end

    #Cette méthode permet de diminuer la valeur du pont
    #
    #@param direction La direction dans laquelle ont veut diminuer le pont
    #
    #Si le pont que l'on diminue n'avait pas de trait alors un pont à deux trait apparait
    #
    #@return true si la valeur à été modifié, false sinon
    def supprSurbrillance(direction)

        return modifSurbrillance(direction, false)

    end


    def marquer()

      @marque = true

    end



    def demarquer()

      @marque = false

    end


    def estPont?()

      return true

    end

end
