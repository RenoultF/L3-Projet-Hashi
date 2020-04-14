
require "../Core/Case.rb"

require "gtk3"

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe permet d'afficher une case de la grille
class CaseUI < Gtk::DrawingArea

  #@casee => La case que l'on va afficher
  attr_reader :casee

  private_class_method :new

  ##
  #Ce constructeur permet de créer un nouveau afficheur de case
  #param::
  # * casee La case à afficher
  # * taille La taille d'une case (en pixels)
  def CaseUI.creer(casee, taille = 40)
    new(casee, taille)
  end

  #:nodoc:
  def initialize(casee, taille = 40)

    super()
    @casee = casee
    @taille = taille

  end
  #:doc:

  ##
  #Cette méthode permet de simuler le clic sur la case
  def clickOn()
    @casee.clickOn()
  end

  ##
  #Cette méthode permet d'afficher la case
  def draw(window)

    cr = window.create_cairo_context

    taille = @taille/20

    cr.set_source_rgb(248/255.0, 236/255.0, 194/255.0)
    cr.rectangle(@taille * @casee.posY() + taille, @taille * @casee.posX() + taille, @taille - taille * 2, @taille - taille * 2)
    cr.fill()

  end

  ##
  #Cette méthode permet de savoir si la case que l'on affiche est une ile
  def estIle?()
    return @casee.estIle?()
  end

  ##
  #Cette méthode permet de savoir si la case que l'on affiche est un pont
  def estPont?()
    return @casee.estPont?()
  end

end
