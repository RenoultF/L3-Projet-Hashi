require 'gtk3'

require '../Core/ConnectSqlite3.rb'

require "../Core/Grille.rb"
require "../Core/Aide.rb"
require "../Core/Sauvegarde.rb"
require "../Core/Compte.rb"
#require "../Core/Checkpoint.rb"
require "../Core/DonnerTechnique.rb"
require "../Core/VerifierGrille.rb"
require "../Core/Action.rb"
require "../Core/Hypothese.rb"
require "../Core/Chrono.rb"
require "../Core/Jeu.rb"

class FenetreJeuUI


    def initialize(mode, grille ,pseudo,window)
        @grille=grille
        @mode = mode
        @pseudo = pseudo
        @scoreCourant = 500 * @grille.tailleX
        puts "Pseudo : #{@pseudo}";
        @compte = Compte.recuperer(@pseudo)

        # puts "Mode : #{@mode}";
        # puts "Taille : #{@taille}";
        # puts "Difficulté : #{@difficulte}";
         
        window.destroy()  
        # CREATION FENETRE 
        @builderJeu = Gtk::Builder.new
        @builderJeu.add_from_file("../glade/jeu.glade")
        @window = @builderJeu.get_object("windowJeu")
        @window.style_context.add_provider(@@CSS_BG_JEU, Gtk::StyleProvider::PRIORITY_USER)
        

        #autre
        @labelPseudo = @builderJeu.get_object("lbPseudo")
        @labelPseudo.set_label("Joueur : "+ @pseudo)
        @labelChrono = @builderJeu.get_object("chrono")
        @labelScore = @builderJeu.get_object("lbVarScore")
        @labelScore.set_label(@grille.score.to_s)

        #Creation de la grille
        grilleJeux = @builderJeu.get_object("grilleJeux")
        grilleJeux.pack_start(@grilleJouable = GrilleJouableUI.new(grille))
        #@jeu = Jeu.creer(@difficulte,@taille,@compte,self, @labelChrono, @labelScore)
        
        @checkpoints = Pile.creer()
        @verifGrille = VerifierGrille.creer(@grille)
        @donnerTech = DonnerTechnique.creer(@grille)

        #fonctions
        @clickUndo = @builderJeu.get_object("btnRetourarr")
        @clickUndo.signal_connect('clicked'){@grille.undo()}

        @btnValid1 = @builderJeu.get_object("btnvalid1")
        @btnValid1.signal_connect('clicked'){@grille.creerHypothese()}

        @btnSuppr1 = @builderJeu.get_object("btnsup1")
        @btnSuppr1.signal_connect('clicked'){@grille.supprimeHypothese(@grilleJouable)}

        # @btnValid2 = @builderJeu.get_object("btnvalid2")
        # @btnValid2.signal_connect('clicked'){@grille.creerHypothese()}

        # @btnSuppr2 = @builderJeu.get_object("btnsup2")
        # @btnSuppr2.signal_connect('clicked'){@grille.supprimeHypothese(@grilleJouable)}

        # @btnValid3 = @builderJeu.get_object("btnvalid3")
        # @btnValid3.signal_connect('clicked'){@grille.creerHypothese()}
        
        # @btnSuppr3 = @builderJeu.get_object("btnsup3")
        # @btnSuppr3.signal_connect('clicked'){@grille.supprimeHypothese(@grilleJouable)}

        @btnSauvegarder = @builderJeu.get_object("btnsave")
        @btnSauvegarder.signal_connect('clicked'){Sauvegarde.recuperer(@compte, @grille).setGrille(@grille).sauvegarder()}

        @btnDonnerTech = @builderJeu.get_object("btnIndice")
        @btnDonnerTech.signal_connect('clicked'){@donnerTech.aider()}

        @btnVerif = @builderJeu.get_object("btnVerif")
        @btnVerif.signal_connect('clicked'){@donnerTech.aider()}

        @chronoGrille = Chrono.new(self,  @labelChrono)
        @threadChrono = Thread.new{@chronoGrille.lancerChrono()}

        #@chronoGrille = Chrono.new(@jeu)
        #@threadChrono = Thread.new{@chronoGrille.lancerChrono()}
        #@threadJeu = Thread.new{@jeu.lanceToi()}
        @window.show_all()
        Gtk.main() 
    end

    def modifScore(val)
        @grille.score += val
        if(@grille.score<0)
            @grille.score = 0
        end
        @labelScore.set_label(@grille.score.to_s)
    end

end