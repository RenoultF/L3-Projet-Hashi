
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require "../Core/Pont.rb"

require "../UI/CaseUI.rb"
require "gtk3"


class PontUI < CaseUI

  attr_reader :couleurPont
  attr_reader :couleurPontCourante

  private_class_method :new

  ##
  #Ce constructeur permet de créer un nouveau afficheur de pont
  #param :
  # * casee La pont à afficher
  # * taille La taille d'une case (40 par defaut)
  def PontUI.creer(pont, taille = 40, couleurPontCourante = [0, 0, 1])

    new(pont, taille, couleurPontCourante)

  end

  #:nodoc:
  def initialize(pont, taille, couleurPontCourante)

    super(pont, taille)

    @couleurPontCourante = couleurPontCourante
    @couleurPont = couleurPontCourante
    @casee.ajouteObservateur(self)

  end
  #:doc:


  def draw(window)#C'est pas joli, fait quelque chose

    cr = window.create_cairo_context
    cr.set_operator(Cairo::OPERATOR_OVER)


    if(@casee.surbrillance)
      cr.set_source_rgba(1, 0, 0, 0.4)


      departY = @taille * @casee.posY()
      departX = @taille * @casee.posX()


      if(@casee.directionSurbrillance == Pont::VERTICAL)

        tailleX = @taille
        tailleY = @taille/2
        departY += @taille/2 - tailleY/2

      elsif(@casee.directionSurbrillance == Pont::HORIZONTAL)

        tailleX = @taille/2
        tailleY = @taille
        departX += @taille/2 - tailleX/2

      end

      cr.rectangle(departY, departX, tailleY, tailleX)
      cr.fill()

    end

    if(@casee.marque)
      cr.set_source_rgba(1, 0, 0, 1)
    else
      cr.set_source_rgb(@couleurPontCourante[0], @couleurPontCourante[1], @couleurPontCourante[2])
    end


    if(@casee.direction == Pont::HORIZONTAL)

      tailleX = 0
      tailleY = @taille

    elsif(@casee.direction == Pont::VERTICAL)

      tailleX = @taille
      tailleY = 0

    else

      tailleX = 0
      tailleY = 0

    end


    departX = @taille * @casee.posX() + tailleY/2
    departY = @taille * @casee.posY() + tailleX/2


    if(@casee.valeur == 1)

      cr.rectangle(departY, departX, tailleY+2, tailleX+2)

    elsif(@casee.valeur == 2)

      tailleDecalage = 2

      decalageY = tailleX/(@taille/tailleDecalage)
      decalageX = tailleY/(@taille/tailleDecalage)

      cr.rectangle(departY - decalageY, departX - decalageX, tailleY+2, tailleX+2)
      cr.rectangle(departY + decalageY, departX + decalageX, tailleY+2, tailleX+2)

    end

    cr.fill()

  end

  def valeur
    return @casee.valeur
  end


  def redoCouleurPont=(couleurPont)

    if(@couleurPont == @couleurPontCourante)
      @couleurPontCourante = couleurPont
    end

    @couleurPont = couleurPont

  end


  def undoCouleurPont=(couleurPont)

    @couleurPont = couleurPont

  end


  ##
  #Cette méthode permet de simuler le clic sur la case
  def clickOn()

    super()

  end

  def actualise

    @couleurPontCourante = @couleurPont

  end

end
