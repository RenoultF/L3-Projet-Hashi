

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

load "../Core/Case.rb"
load "../Core/Couleur.rb"

##
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

    #@surbrillance => Booléen pour l'affichage, si égal à true le pont sera affiché en surbrillance
    attr_accessor :surbrillance

    #@directionSurbrillance => La direction dans laquelle le pont en surbrillance est dirigé
    attr_accessor :directionSurbrillance

    #@marque => Booléen pour l'affichage, si égal à true le pont sera affiché en surbrillance rouge
    attr_accessor :marque

    #:nodoc:
    def Pont.verifieDirection(direction) #privée
      return true if([NULLE, HORIZONTAL, VERTICAL].include?(direction))
      return false
    end
    #:doc:


    private_class_method :new

    ##
    #Ce constructeur permet de créer un nouveau pont
    #param :
    # * posX La position sur l'axe des abscisse
    # * posY La position sur l'axe des ordonnées
    # * grille La grille sur laquelle se trouve le pont
    def Pont.creer(posX, posY, grille)

        Pont.construit(posX, posY, grille, NULLE, 0)

    end

    ##
    #Ce constructeur permet de créer un nouveau pont avec des valeurs
    #param :
    # * posX La position sur l'axe des abscisse
    # * posY La position sur l'axe des ordonnées
    # * grille La grille sur laquelle se trouve le pont
    # * direction La direction du pont
    # * valeur La taille du pont
    def Pont.construit(posX, posY, grille, direction, valeur)
        if(Pont.verifieDirection(direction))
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
        @directionSurbrillance = NULLE
        @couleurPont = Couleur::NOIR
        @couleurPontCourante = Couleur::NOIR

    end
    #:doc:

    ##
    #Cette méthode permet de connaitre la couleur que prendrait le pont s'il était modifié
    #return :
    # * La couleur du pont s'il était modifié (Couleur.rb)
    def couleurPont
      return @couleurPont
    end

    ##
    #Cette méthode permet de modifier la couleur que prendrait le pont s'il était modifié
    #param :
    # * couleur La couleur que prendrait le pont s'il était modifié (Couleur.rb)
    def couleurPont=(couleur)
      @couleurPont = couleur
    end

    ##
    #Cette méthode permet de connaitre la couleur du pont
    #return :
    # * La couleur du pont (Couleur.rb)
    def couleurPontCourante
      return @couleurPontCourante
    end

    ##
    #Cette méthode permet de modifier la couleur du pont
    #param :
    # * couleur La couleur du pont (Couleur.rb)
    def couleurPontCourante=(couleur)
      @couleurPontCourante = couleur
    end

    ##
    #Cette méthode permet de modifier la couleur que devrais prendre le pont s'il est modifié
    #ainsi que sa couleur courante si elle était la même que la couleur après modification
    #Utilisé par les hypothèses
    def redoCouleurPont(couleurPont)
      if(@couleurPont == @couleurPontCourante)
        @couleurPontCourante = couleurPont
      end
      @couleurPont = couleurPont
    end

    ##
    #alias de couleurPont=(couleur)
    def undoCouleurPont(couleurPont)
      @couleurPont = couleurPont
    end


    ##
    #Cette méthode permet de simuler un "clic" sur le pont
    def clickOn()
      @grille.clickOnPont(self)
    end


    ##
    #Cette méthode permet de remettre à zéro le pont
    def raz()

      @valeur = 0
      @direction = NULLE
      @surbrillance = false
      @marque = false
      @directionSurbrillance = NULLE

    end



    ##
    #Cette méthode permet de comparer des ponts entre-eux
    #param :
    # * autre L'autre pont à comparer
    #return :
    # * 0 si les ponts sont égaux
    # * un nombre négatif si le premier pont est inférieur au deuxième
    # * un nombre positif si le premier pont est supérieur au deuxième
    def <=>(autre)
      if(!autre.estPont?())
        return 1
      end
      if(@direction != autre.direction)
          return @direction <=> autre.direction
      end
      if(@valeur != autre.valeur)
          return @valeur <=> autre.valeur
      end
      return 0
    end

    ##
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
            #On modifie la valeur du pont si la direction donné est la bonne
            if(@direction == direction)
                @valeur = (@valeur + valeur) % (MAX_LIGNE + 1)
                if(@valeur == 0)
                    @direction = NULLE
                end
                @couleurPontCourante = @couleurPont
                return true
            end
            return false
        #On crée un nouveau pont
        elsif(@direction == NULLE)
            @direction = direction
            @valeur = valeur
            @couleurPontCourante = @couleurPont
            return true
        end
    end

    private def modifSurbrillance(direction, valeur)
      if(@direction != NULLE)
        if(@direction == direction)
          @surbrillance = valeur
          @directionSurbrillance = direction
          return true
        end
        return false
      elsif(@direction == NULLE)
        @surbrillance = valeur
        @directionSurbrillance = direction
        return true
      end
    end
    #:doc:

    ##
    #Cette méthode permet d'augmenter la valeur du pont
    #param :
    # * direction La direction dans laquelle on veut augmenter le pont
    #Si le pont que l'on augmente avait 2 trait alors le pont disparait
    #return :
    # * true Si la valeur à été modifié
    # * false Sinon
    def augmenteValeur(direction)
        return modifValeur(direction, 1)
    end

    ##
    #Cette méthode permet de diminuer la valeur du pont
    #param :
    # * direction La direction dans laquelle on veut diminuer le pont
    #Si le pont que l'on diminue n'avait pas de trait alors un pont à deux trait apparait
    #return :
    # * true Si la valeur à été modifié
    # * false Sinon
    def diminueValeur(direction)
        return modifValeur(direction, MAX_LIGNE)
    end


    ##
    #Cette méthode permet de mettre en surbrillance le pont
    #param :
    # * direction La direction dans laquelle on veut mettre en surbrillance le pont
    #return :
    # * true Si le pont a été mis en surbrillance
    # * false Sinon
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

    ##
    #Cette méthode permet de modifier le marquage du pont quand il est faux
    def marquer()
      @marque = true
    end



    ##
    #Cette méthode permet de modifier le marquage du pont quand il est valide
    def demarquer()
      @marque = false
    end


    ##
    #Cette méthode retourne vrai
    #return :
    # * true
    def estPont?()
      return true
    end

end
