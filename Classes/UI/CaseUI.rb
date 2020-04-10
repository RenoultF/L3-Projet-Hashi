
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require "../Core/Case.rb"

require "gtk3"

##
#Cette classe permet d'afficher une case de la grille
class CaseUI < Gtk::DrawingArea

  attr_reader :casee

  private_class_method :new

  ##
  #Ce constructeur permet de créer un nouveau afficheur de case
  #param :
  # * casee La case à afficher
  # * taille La taille d'une case (40 par defaut)
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

  #  cr = window.create_cairo_context


  #  cr.set_source_rgb(255, 0, 0)
  #  cr.rectangle(@taille * @casee.posY(), @taille * @casee.posX(), @taille, @taille)
  #  cr.fill()

  end

  def estIle?()

    return @casee.estIle?()

  end


  def estPont?()

    return @casee.estPont?()

  end

end
