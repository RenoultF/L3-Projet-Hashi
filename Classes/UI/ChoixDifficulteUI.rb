

##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require 'gtk3'

##
#Cette classe permet à l'utilisateur de choisir entre plusieurs difficulté
class ChoixDifficulteUI < Gtk::Box

  attr_reader :menu


  def initialize(menu)

    super(:vertical, 0)

    @menu = menu
    @boutons = Gtk::Box.new(:horizontal, 0)

    for i in [[0, 'Facile'], [1, 'Normal'], [2, 'Difficile']]

      temp = Gtk::Button.new(:label => "#{i[1]}")
      temp.signal_connect "clicked" do
        @menu.difficulte=i[0]
      end
      @boutons.pack_start(temp, :expand => true, :fill => true)

    end

    temp = Gtk::Box.new(:vertical, 0)

    temp.pack_start(Gtk::Label.new("Difficulté de la grille"), :expand => true, :fill => true)
    temp.pack_start(@boutons, :expand => true, :fill => true)

    pack_start(temp, :expand => true, :fill => true)

  end

end
