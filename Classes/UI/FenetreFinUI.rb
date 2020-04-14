require 'gtk3'

require "../UI/Menu.rb"

require "../CSS/Style.rb"

class FenetreFinUI

    def initialize(grille,compte,window)
    
        @grille = grille
        window.destroy()
        @builderFin = Gtk::Builder.new
        @builderFin.add_from_file("../glade/Fin.glade")

        @windowFin = @builderFin.get_object("FenetreFin")

        @imgEtoile = @builderFin.get_object("image2")
        if(@grille.score>(500*@grille.tailleX / 2))
            #mettre a jour pour image 3 etoile
        elsif(@grille.score>(500*@grille.tailleX / 3))
            #mettre a jour pour image 2 etoles
        else
            #mettre a jour pour image 1 etoiles
        end
        #fonctions
        @clickRetour = @builderFin.get_object("button1")
        @clickRetour.signal_connect('clicked'){
            @grille.recommencer()
            @grille.sauvegarder(compte)
            @windowFin.destroy()
            Menu.new()
        }

        @clickQuitter = @builderFin.get_object("button3")
        @clickQuitter.signal_connect('clicked'){
            @grille.recommencer()
            @grille.sauvegarder(compte)
            Gtk.main_quit
        }

        @clickMapSuivante = @builderFin.get_object("button2")
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




