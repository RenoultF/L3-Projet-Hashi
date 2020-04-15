require_relative "../CSS/Style.rb"

##
#
# Auteur:: Adrien PITAULT
# Version:: 0.1
# 
#Initialise  la fenetre de règle

class ReglesUI

    def initialize()
        @builderRegles = Gtk::Builder.new
        @builderRegles.add_from_file("lib/Hashiparmentier/glade/regles.glade")

        @window = @builderRegles.get_object("windowRegles")

        @window.signal_connect('destroy') { |_widget| Gtk.main_quit }
        @window.style_context.add_provider(@@CSS_REGLES, Gtk::StyleProvider::PRIORITY_USER)

        @btnQuitter = @builderRegles.get_object("btnQuitter")
        @btnQuitter.signal_connect('clicked') { |_widget| @window.destroy() }
        @btnQuitter.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)

        @window.show_all()
        Gtk.main()
    end
end
