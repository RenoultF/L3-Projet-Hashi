
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require "../Core/Ile.rb"

require "../UI/CaseUI.rb"
require "gtk3"
require "cairo"


class IleUI < CaseUI

  def initialize(ile, taille, cameraX)

    super(ile, taille, cameraX)

    self.signal_connect "button-press-event" do

      @casee.clickOn()

    end

  end


  def draw(window)

    cr = window.create_cairo_context

    if(@casee.estDernierIle())
      cr.set_source_rgb(255, 0, 0)
    else
      cr.set_source_rgb(0, 255, 0)
    end
    cr.circle(@taille * @casee.posY() + @taille/2, @taille * @casee.posX() + @taille/2, @taille/2)
    cr.stroke()

    text = @casee.valeur.to_s()

    cr.select_font_face "Serif", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL
    cr.set_font_size @taille/2

    width = cr.text_extents(text).width
    height = cr.text_extents(text).height

    cr.move_to(@taille * @casee.posY() + @taille/2 - width/2, @taille * @casee.posX() + @taille/2 + height/2)
    cr.show_text(text)

  end



end
