

require "../UI/ReglesUI.rb"
require 'gtk3'




class FenetreReglesUI < Gtk::Window

  def initialize

    super("Règles du Hashiparmentier")

    signal_connect "delete_event" do
      hide_on_delete()
    end

    add(ReglesUI.new())

  end

end
