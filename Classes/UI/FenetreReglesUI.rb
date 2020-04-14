

require "../UI/ReglesUI.rb"
require 'gtk3'




##
# PAS UTILISE DANS LE VERSION FINALE
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
class FenetreReglesUI < Gtk::Window

  def initialize

    super("Règles du Hashiparmentier")

    signal_connect "delete_event" do
      hide_on_delete()
    end

    add(ReglesUI.new())

  end

end
