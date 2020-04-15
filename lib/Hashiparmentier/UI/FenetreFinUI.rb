require 'gtk3'

require_relative "../UI/Menu.rb"

require_relative "../CSS/Style.rb"

class FenetreFinUI

    def initialize(grille,compte,window)

        @grille = grille
        window.destroy()
        @builderFin = Gtk::Builder.new
        @builderFin.add_from_file("lib/Hashiparmentier/glade/Fin.glade")

        @windowFin = @builderFin.get_object("FenetreFin")
        @windowFin.style_context.add_provider(@@CSS_FIN, Gtk::StyleProvider::PRIORITY_USER)
        @windowFin.signal_connect('destroy') { |_widget| Gtk.main_quit }
        #(500*@grille.tailleX / 2)
        @imgEtoile = @builderFin.get_object("imgScore")
        if(@grille.score>500)
            @imgEtoile.style_context.add_provider(@@CSS_BG_SCORE3, Gtk::StyleProvider::PRIORITY_USER)
        elsif(@grille.score>(500*@grille.tailleX / 3))
            @imgEtoile.style_context.add_provider(@@CSS_BG_SCORE2, Gtk::StyleProvider::PRIORITY_USER)
        else
            @imgEtoile.style_context.add_provider(@@CSS_BG_SCORE1, Gtk::StyleProvider::PRIORITY_USER)
        end
        #fonctions
        @clickRetour = @builderFin.get_object("button1")
        @clickRetour.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @clickRetour.signal_connect('clicked'){
            @grille.recommencer()
            @grille.sauvegarder(compte)
            @windowFin.destroy()
            Menu.new()
        }

        @clickQuitter = @builderFin.get_object("button3")
        @clickQuitter.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @clickQuitter.signal_connect('clicked'){
            @grille.recommencer()
            @grille.sauvegarder(compte)
            @windowFin.destroy()
            Gtk.main_quit
        }
        

        @clickMapSuivante = @builderFin.get_object("button2")
        @clickMapSuivante.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @clickMapSuivante.signal_connect('clicked'){
            @grille.recommencer()
            @grille.sauvegarder(compte)
            puts "mode aventure MAJ"
        }

        @labelHsJoueur = @builderFin.get_object("valeurHS")
        @labelHsJoueur.set_label(@grille.getMeilleurScore(compte).to_s)

        @labelScoreJoueur = @builderFin.get_object("scoreJoueur")
        @labelScoreJoueur.set_label(@grille.score.to_s)

        @windowFin.show_all()
        # Appel de la gestion des signaux
        Gtk.main()
    end
end
