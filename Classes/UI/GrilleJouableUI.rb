
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020


require "../UI/GrilleUI.rb"


##
#Cette classe repréésente une _GrilleUI dans laquelle on peut jouer
class GrilleJouableUI < GrilleUI

  def initialize(grille, taille = 40)

    super(grille, taille)

    self.signal_connect "button-press-event" do |widget, event|
      self.clickOn(widget, event)
    end

    self.add_events([:button_press_mask])

  end


  ##
  #Cette méthode permet de gérer les clics sur la grille
  def clickOn(widget, event)

    y = (event.x/@taille).to_i
    x = (event.y/@taille).to_i

    if(!sortLimite?(x, y))
      getCase(x, y).clickOn()
    end

    self.queue_draw()

    end


end
