
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require '../Core/Compte.rb'
require '../Core/Sauvegarde.rb'
require '../Core/ConnectSqlite3.rb'

require '../UI/GrilleUI.rb'
require '../UI/MenuUI.rb'
require '../UI/ChoixGrilleUI.rb'
require '../UI/RacineUI.rb'
require 'gtk3'


class Fenetre < Gtk::Window

  def initialize()

    super()

    set_title('Hashiparmentier')

    signal_connect "destroy" do

      Gtk.main_quit

    end

    set_default_size 100, 100

    set_window_position Gtk::WindowPosition::CENTER

    self.add(RacineUI.new())

=begin
    liste = Sauvegarde.liste(Compte.recuperer("polo"), 7, 0)

    @draw = GrilleUI.new(liste[0].getGrille(), 20)
=begin
    @draw.signal_connect "draw" do
      @draw.on_draw()
    end

    @draw.signal_connect "button-press-event" do |widget, event|
      @draw.clickOn(widget, event)
    end


    @draw.add_events([:button_press_mask])

    self.add(@draw)
=end

    show_all

  end

end
