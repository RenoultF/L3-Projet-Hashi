
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020


require "../UI/GrilleUI.rb"


##
#Cette classe repréésente une GrilleUI dans laquelle on peut jouer
class GrilleJouableUI < GrilleUI

  def initialize(grille, taille = 40)

    super(grille, taille)

    self.signal_connect "button-press-event" do |widget, event|
      self.clickOn(widget, event)
    end

    self.add_events([:button_press_mask])

  end

end
