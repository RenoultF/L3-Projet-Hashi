
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require "../Core/Case.rb"

require "gtk3"


class CaseUI < Gtk::DrawingArea

  attr_reader :casee

  def initialize(casee, taille = 40, cameraX = 0)

    super()

    @casee = casee

    @taille = taille

    @cameraX = cameraX

  end

  def clickOn()

    @casee.clickOn()

  end


  def draw(window)

  #  cr = window.create_cairo_context


  #  cr.set_source_rgb(255, 0, 0)
  #  cr.rectangle(@taille * @casee.posY(), @taille * @casee.posX(), @taille, @taille)
  #  cr.fill()

  end



end
