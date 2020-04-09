
require "../Core/Pont.rb"

require "../UI/CaseUI.rb"
require "gtk3"


class PontUI < CaseUI

  def initialize(pont, taille, cameraX)

    super(pont, taille, cameraX)

  end


  def draw(window)

    cr = window.create_cairo_context
    cr.set_operator(Cairo::OPERATOR_OVER)


    if(@casee.direction == Pont::HORIZONTAL)

      tailleX = 0
      tailleY = @taille

    elsif(@casee.direction == Pont::VERTICAL)

      tailleX = @taille
      tailleY = 0

    else

      tailleX = @taille
      tailleY = @taille

    end


    departX = @taille * @casee.posX() + tailleY/2
    departY = @taille * @casee.posY() + tailleX/2

    arriveX = departX + tailleX
    arriveY = departY + tailleY


    cr.set_source_rgba(0, 0, 255, 255)

    if(@casee.valeur == 1)

      cr.rectangle(departY, departX, tailleY+2, tailleX+2)
      cr.fill()

    elsif(@casee.valeur == 2)

      tailleDecalage = 2

      decalageY = tailleX/(@taille/tailleDecalage)
      decalageX = tailleY/(@taille/tailleDecalage)

      cr.move_to(departY - decalageY, departX - decalageX)
      cr.line_to(arriveY - decalageY, arriveX - decalageX)

      cr.move_to(departY + decalageY, departX + decalageX)
      cr.line_to(arriveY + decalageY, arriveX + decalageX)
      cr.stroke()

      cr.rectangle(@taille * @casee.posY(), @taille * @casee.posX(), tailleY, tailleX)
      cr.fill()

    end

    cr.stroke_preserve()


    if(@casee.surbrillance)
      cr.set_source_rgba(255, 0, 0, 128)
      cr.rectangle(@taille * @casee.posY(), @taille * @casee.posX(), tailleY, tailleX)
      cr.fill()
    end



  end

end
