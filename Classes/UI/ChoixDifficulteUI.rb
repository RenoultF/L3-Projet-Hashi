

##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require 'gtk3'

##
#Cette classe permet à l'utilisateur de choisir entre plusieurs difficulté
class ChoixDifficulteUI < Gtk::Box

  attr_reader :menu


  def initialize(menu)

    super(:horizontal, 10)

    @menu = menu

    for i in [0, 1, 2]

      temp = Gtk::Button.new(:label => "#{i}")
      temp.signal_connect "clicked" do
        @menu.difficulte=i
      end
      self.add(temp)

    end

  end

end
