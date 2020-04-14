require 'gtk3'

require "../UI/Menu.rb"

require "../CSS/Style.rb"

class FenetreJeuUI

    def initialize(windows, grille)
        @grille = grille
        @windowsJeu = windows
        @windowsJeu.destroy()

        @windowFin = @builderJeu.get_object("FenetreFin")


        @builderFin = Gtk::Builder.new
        @builderFin.add_from_file("../glade/Fin.glade")


        #fonctions
        @clickRetour = @builderFin.get_object("button1")
        @clickRetour.signal_connect('clicked'){
            @grille.recommencer()
            @windowFin.destroy()
            Menu.new()
        }

        @clickQuitter = @builderFin.get_object("button3")
        @clickQuitter.signal_connect('clicked'){
            @grille.recommencer()
            Gtk.main_quit
        }

        @clickMapSuivante = @builderFin.get_object("button2")
        @clickQuitter.signal_connect('clicked'){
            @grille.recommencer()
            puts "mode aventure inch"
        }

        @labelHsJoueur = @builderFin.get_object("valeurHS")
        @labelHsJoueur.set_label(@grille.getMeilleurScore().to_s)

        @labelScoreJoueur = @builderFin.get_object("scoreJoueur")
        @labelScoreJoueur.set_label(@grille.score.to_s)

        @windowFin.show_all()
        # Appel de la gestion des signaux
        Gtk.main()
    end
end




