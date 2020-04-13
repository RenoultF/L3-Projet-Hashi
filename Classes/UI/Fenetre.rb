
require '../UI/RacineUI.rb'
require 'gtk3'

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
class Fenetre < Gtk::Window

  def initialize()

    super()
    set_title('Hashiparmentier')

    signal_connect "destroy" do
      Gtk.main_quit
    end

    set_window_position Gtk::WindowPosition::CENTER

    add(RacineUI.new())

    maximize
    show_all

  end

end
