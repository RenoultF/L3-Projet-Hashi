
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require "../Core/Ile.rb"

require "../UI/CaseUI.rb"
require "gtk3"
require "cairo"


##
#Cette classe permet d'afficher une ile de la grille
class IleUI < CaseUI

  private_class_method :new

  ##
  #Ce constructeur permet de créer un nouveau afficheur d'ile
  #param :
  # * ile L'ile à afficher
  # * taille La taille d'une case (40 par defaut)
  def IleUI.creer(ile, taille = 40)

    new(ile, taille)

  end

  #:nodoc:
  def initialize(ile, taille)

    super(ile, taille)

  end
  #:doc:

  ##
  #Cette méthode permet de dessiner l'ile
  #param :
  # * window La fenetre sur laquelle l'ile va etre afficher
  def draw(window)

    cr = window.create_cairo_context

    positionY = @taille * @casee.posY() + @taille/2
    positionX = @taille * @casee.posX() + @taille/2

    choixCouleur(cr)

    cr.circle(positionY, positionX, @taille/2)

    if(@casee.getCapaciteResiduelle() <= 0)
      cr.fill()
      cr.set_source_rgb(255, 255, 255)
    else
      cr.stroke()
    end

    text = @casee.valeur.to_s()

    cr.select_font_face "Serif", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL
    cr.set_font_size @taille/2

    width = cr.text_extents(text).width
    height = cr.text_extents(text).height #Centrer le texte

    cr.move_to(positionY - width/2, positionX + height/2)
    cr.show_text(text)

  end


  private def choixCouleur(cr)

    cr.set_source_rgb(0, 255, 0)
    cr.set_source_rgb(0, 0, 255) if @casee.estDernierIle()
    cr.set_source_rgb(255, 0, 0) if @casee.getCapaciteResiduelle() < 0

  end

end
