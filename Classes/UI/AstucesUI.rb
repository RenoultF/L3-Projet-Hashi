load '../CSS/Style.rb'

class AstucesUI

    def initialize()       
        @builderAide = Gtk::Builder.new
        @builderAide.add_from_file("../glade/astuces.glade")

        @window = @builderAide.get_object("windowAstuces")

        @window.signal_connect('destroy') { |_widget| Gtk.main_quit }
        @window.style_context.add_provider(@@CSS_ASTUCES, Gtk::StyleProvider::PRIORITY_USER)

        @btnQuitter = @builderAide.get_object("btnQuitter")
        @btnQuitter.signal_connect('clicked') { |_widget| @window.destroy() }
        @btnQuitter.style_context.add_provider(@@CSS_BUTTON_ROSE, Gtk::StyleProvider::PRIORITY_USER)		


        @window.show_all()
        Gtk.main() 
    end
end