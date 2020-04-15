

require 'gtk3'

##
# PAS UTILISE DANS LE VERSION FINALE
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Permet de choisir une taille
class ChoixTailleUI < Gtk::Box

  attr_reader :menu

  def initialize(menu)

    super(:vertical, 0)

    @menu = menu
    @boutons = Gtk::Box.new(:horizontal, 0)

    for i in [7, 10, 15]

      temp = Gtk::Button.new(:label => "#{i}*#{i}")
      temp.name=i.to_s()
      temp.signal_connect "clicked" do |widget, event|
        @menu.taille=widget.name.to_i()
      end
      @boutons.pack_start(temp, :expand => true, :fill => true)

    end

    temp = Gtk::Box.new(:vertical, 0)

    temp.pack_start(Gtk::Label.new("Taille de la grille"), :expand => true, :fill => true)
    temp.pack_start(@boutons, :expand => true, :fill => true)

    pack_start(temp, :expand => true, :fill => true)


  end

end
