
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require "../Core/Pont.rb"

require "../UI/CaseUI.rb"
require "gtk3"


##
#Cette classe permet d'afficher un pont de la grille
class PontUI < CaseUI

  private_class_method :new

  ##
  #Ce constructeur permet de créer un nouveau afficheur de pont
  #param :
  # * casee La pont à afficher
  # * taille La taille d'une case (40 par defaut)
  def PontUI.creer(pont, taille = 40)

    new(pont, taille)

  end

  #:nodoc:
  def initialize(pont, taille)

    super(pont, taille)

  end
  #:doc:


  private def afficheSurbrillance(cr)

    cr.set_source_rgba(1, 0, 0, 0.4)

    calculPosition(@taille/2, 0)
    cr.rectangle(@departY, @departX, @tailleY, @tailleX)
    cr.fill()

  end


  private def calculPosition(largeur = 4, tailleDecalage = 4)

    @departX = @taille * @casee.posX()
    @departY = @taille * @casee.posY()

    if(@casee.direction == Pont::HORIZONTAL || @casee.directionSurbrillance == Pont::HORIZONTAL)

      @tailleX = largeur
      @tailleY = @taille
      @departX += @tailleY/2 - @tailleX/2
      @decalageY = 0
      @decalageX = tailleDecalage

    elsif(@casee.direction == Pont::VERTICAL || @casee.directionSurbrillance == Pont::VERTICAL)

      @tailleX = @taille
      @tailleY = largeur
      @departY += @tailleX/2 - @tailleY/2
      @decalageY = tailleDecalage
      @decalageX = 0

    else

      @tailleX = 0
      @tailleY = 0

    end


  end


  private def affichePontSimple(cr, largeur = 4, tailleDecalage = 4)

    calculPosition(4, 4)
    cr.rectangle(@departY, @departX, @tailleY, @tailleX)
    cr.fill()

  end

  private def affichePontDouble(cr, largeur = 4, tailleDecalage = 4)

    calculPosition(4, 4)
    cr.rectangle(@departY - @decalageY, @departX - @decalageX, @tailleY, @tailleX)
    cr.rectangle(@departY + @decalageY, @departX + @decalageX, @tailleY, @tailleX)
    cr.fill()

  end

  ##
  #Cette méthode permet de dessiner le pont
  #param :
  # * window La fenetre sur laquelle l'ile va etre afficher
  def draw(window)

    cr = window.create_cairo_context

    afficheSurbrillance(cr) if @casee.surbrillance

    if(@casee.marque)
      cr.set_source_rgb(1, 0, 0)
    else
      cr.set_source_rgb(@casee.couleurPontCourante.rouge, @casee.couleurPontCourante.vert, @casee.couleurPontCourante.bleu)
    end

    affichePontSimple(cr) if @casee.valeur == 1
    affichePontDouble(cr) if @casee.valeur == 2

  end

  ##
  #Cette méthode permet de retourner la valeu du pont
  def valeur
    return @casee.valeur
  end

  ##
  #Cette méthode permet de simuler le clic sur la case
  def clickOn()

    super()

  end

end
