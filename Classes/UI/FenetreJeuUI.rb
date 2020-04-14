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
require "../UI/Menu.rb"

require "../UI/AideJeuUI.rb"
require "../UI/ReglesUI.rb"
require "../UI/AstucesUI.rb"
require "../CSS/Style.rb"

class FenetreJeuUI


    def initialize(mode, grille ,pseudo,window)
        @grille=grille
        @mode = mode
        @pseudo = pseudo
        @scoreCourant = 500 * @grille.tailleX
        puts "Pseudo : #{@pseudo}";
        @compte = Compte.recuperer(@pseudo)

        # puts "Mode : #{@mode}";
        puts "Taille : #{@taille}";
        # puts "Difficulté : #{@difficulte}";

        window.destroy()
        # CREATION FENETRE
        @builderJeu = Gtk::Builder.new
        @builderJeu.add_from_file("../glade/jeu.glade")
        @window = @builderJeu.get_object("windowJeu")
        if (@grille.tailleX == 15)
            @window.style_context.add_provider(@@CSS_BG_JEU15, Gtk::StyleProvider::PRIORITY_USER)
        else
            @window.style_context.add_provider(@@CSS_BG_JEU, Gtk::StyleProvider::PRIORITY_USER)
        end
        


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

        @clickRedo = @builderJeu.get_object("btnRetourarr1")
        @clickRedo.signal_connect('clicked'){@grille.redo()}

        @btnReinit = @builderJeu.get_object("btnReinit1")
        @btnReinit.signal_connect('clicked'){@grille.recommencer()}

        @btnRetour = @builderJeu.get_object("btnRetour")
        @btnRetour.signal_connect('clicked'){
            Sauvegarde.recuperer(@compte, @grille).setGrille(@grille).sauvegarder()
            @window.destroy()
            Menu.new()
        }

        @btnValid1 = @builderJeu.get_object("btnvalid1")
        @btnValid1.signal_connect('clicked'){@grille.creerHypothese()}

        @btnSuppr1 = @builderJeu.get_object("btnsup1")
        @btnSuppr1.signal_connect('clicked'){@grille.supprimeHypothese(@grilleJouable)}

        @btnSauvegarder = @builderJeu.get_object("btnsave")
        @btnSauvegarder.signal_connect('clicked'){@grille.sauvegarder()}

        @btnDonnerTech = @builderJeu.get_object("btnIndice")
        @btnDonnerTech.signal_connect('clicked'){puts @donnerTech.aider()}

        @btnVerif = @builderJeu.get_object("btnVerif")
        @btnVerif.signal_connect('clicked'){@verifGrille.aider()}

        @chronoGrille = Chrono.new(self,  @labelChrono)
        @threadChrono = Thread.new{@chronoGrille.lancerChrono()}

        @btnAide = @builderJeu.get_object("btnAide")
        @btnRegles = @builderJeu.get_object("btnRegles")
        @btnAstuces = @builderJeu.get_object("btnAstuces")
    
        @btnAide.style_context.add_provider(@@CSS_BTN_TOPMENU, Gtk::StyleProvider::PRIORITY_USER)
        @btnRegles.style_context.add_provider(@@CSS_BTN_TOPMENU, Gtk::StyleProvider::PRIORITY_USER)
        @btnAstuces.style_context.add_provider(@@CSS_BTN_TOPMENU, Gtk::StyleProvider::PRIORITY_USER)
    
        @btnAide.signal_connect('clicked') { |_widget| AfficherAideJeu() }
        @btnRegles.signal_connect('clicked') { |_widget| AfficherRegles()  }
        @btnAstuces.signal_connect('clicked') { |_widget| AfficherAstuces() }

        @boxStat = @builderJeu.get_object("boxStat")
        @boxStat.style_context.add_provider(@@CSS_BOX_STAT, Gtk::StyleProvider::PRIORITY_USER)
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

    def AfficherAideJeu()
		@aide = AideJeuUI.new()
	end

	def AfficherRegles()
		@regles = ReglesUI.new()
	end

	def AfficherAstuces()
		@astuces = AstucesUI.new()
	end

end
