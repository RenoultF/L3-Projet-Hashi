load '../CSS/Style.rb'

class ReglesUI

    def initialize()       
        @builderRegles = Gtk::Builder.new
        @builderRegles.add_from_file("../glade/regles.glade")

        @window = @builderRegles.get_object("REGLES1")

        @window.signal_connect('destroy') { |_widget| Gtk.main_quit }
        # @window.style_context.add_provider(@@CSS_Regles, Gtk::StyleProvider::PRIORITY_USER)

        @btnQuitter = @builderRegles.get_object("Terminer")
        @btnQuitter.signal_connect('clicked') { |_widget| @window.destroy() }
        # @btnQuitter.style_context.add_provider(@@CSS_BUTTON_ROSE, Gtk::StyleProvider::PRIORITY_USER)		


        @window.show_all()
        Gtk.main() 
    end
end