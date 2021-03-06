require_relative '../CSS/Style.rb'
##
#
# Auteur:: Adrien PITAULT
# Version:: 0.1
# 
#Initialise la fenetre d'aide du menu
class AideUI

    def initialize()
        @builderAide = Gtk::Builder.new
        @builderAide.add_from_file("lib/Hashiparmentier/glade/aide.glade")

        @window = @builderAide.get_object("windowAide")

        @window.signal_connect('destroy') { |_widget| Gtk.main_quit }
        @window.style_context.add_provider(@@CSS_AIDE, Gtk::StyleProvider::PRIORITY_USER)

        @btnQuitter = @builderAide.get_object("btnQuitter")
        @btnQuitter.signal_connect('clicked') { |_widget| @window.destroy() }
        @btnQuitter.style_context.add_provider(@@CSS_BUTTON_ROSE, Gtk::StyleProvider::PRIORITY_USER)


        @window.show_all()
        Gtk.main()
    end
end
