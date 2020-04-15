require 'gtk3'

require_relative "../UI/Menu.rb"
require_relative "../Core/Sauvegarde.rb"
require_relative "../Core/Compte.rb"

require_relative "../CSS/Style.rb"

class FenetreFinUI

    def initialize(mode,grille,compte,window)
        @mode = mode
        @grille = grille
        window.destroy()
        @builderFin = Gtk::Builder.new
        @builderFin.add_from_file("lib/Hashiparmentier/glade/Fin.glade")

        @windowFin = @builderFin.get_object("FenetreFin")
        @windowFin.style_context.add_provider(@@CSS_FIN, Gtk::StyleProvider::PRIORITY_USER)
        @windowFin.signal_connect('destroy') { |_widget| 
            @grille.recommencer()
            @grille.sauvegarder(compte)
            @windowFin.destroy()
            Gtk.main_quit }
        
        @imgEtoile = @builderFin.get_object("imgScore")
        if(@grille.score>(500*@grille.tailleX * 0.7))
            @imgEtoile.style_context.add_provider(@@CSS_BG_SCORE3, Gtk::StyleProvider::PRIORITY_USER)
        elsif(@grille.score>(500*@grille.tailleX / 0.4))
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
            Gtk.main_quit
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
        if(@mode==2)
            if(@grille.difficulte<2)
                nvDifficulte = @grille.difficulte+1
                nvtaille = @grille.tailleX
            else
                nvDifficulte = 0
                case @grille.tailleX
                when 7
                    nvtaille = 10
                when 10
                    nvtaille = 15
                when 15
                    nvtaille = 20
                end
            end
            if(nvtaille==20)
                @clickMapSuivante.set_label("Terminé")
                @clickMapSuivante.signal_connect('clicked'){
                    @grille.recommencer()
                    @grille.sauvegarder(compte)
                    @windowFin.destroy()
                    Gtk.main_quit
                }
            else
                @clickMapSuivante.signal_connect('clicked'){
                    @grille.recommencer()
                    @grille.sauvegarder(compte)
                    liste = Sauvegarde.liste(Compte.recuperer_ou_creer(compte.name), nvtaille, nvDifficulte)
                    nvgrille = liste[rand(3)].getGrille()
                    FenetreJeuUI.new(@mode, nvgrille,compte.name,@windowFin,nil)
                    Gtk.main_quit
                }
            end
        end

        @labelHsJoueur = @builderFin.get_object("valeurHS")
        @labelHsJoueur.set_label(@grille.getMeilleurScore(compte).to_s)

        @labelScoreJoueur = @builderFin.get_object("scoreJoueur")
        @labelScoreJoueur.set_label(@grille.score.to_s)

        @windowFin.show_all()
        # Appel de la gestion des signaux
        Gtk.main()
    end
end
