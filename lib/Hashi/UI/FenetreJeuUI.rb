require 'gtk3'

require_relative '../Core/ConnectSqlite3.rb'

require_relative "../Core/Grille.rb"
require_relative "../Core/Aide.rb"
require_relative "../Core/Sauvegarde.rb"
require_relative "../Core/Compte.rb"
#require_relative "../Core/Checkpoint.rb"
require_relative "../Core/DonnerTechnique.rb"
require_relative "../Core/VerifierGrille.rb"
require_relative "../Core/Action.rb"
require_relative "../Core/Hypothese.rb"
require_relative "../Core/Chrono.rb"
require_relative "../Core/Jeu.rb"

require_relative "../UI/Menu.rb"
require_relative "../UI/FenetreFinUI.rb"
require_relative "../UI/AideJeuUI.rb"
require_relative "../UI/ReglesUI.rb"
require_relative "../UI/AstucesUI.rb"
require_relative "../UI/GrilleJouableUI.rb"
require_relative "../CSS/Style.rb"

class FenetreJeuUI


    def initialize(mode, grille ,pseudo,window,window1)
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
        window1.destroy()
        # CREATION FENETRE
        @builderJeu = Gtk::Builder.new
        @builderJeu.add_from_file("lib/Hashi//glade/jeu.glade")
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
        @clickUndo = @builderJeu.get_object("btnUndo")
        @clickUndo.signal_connect('clicked'){@grille.undo()}

        @clickRedo = @builderJeu.get_object("btnRedo")
        @clickRedo.signal_connect('clicked'){@grille.redo()}

        @btnReinit = @builderJeu.get_object("btnReinit")
        @btnReinit.signal_connect('clicked'){@grille.recommencer()}

        @btnRetour = @builderJeu.get_object("btnRetour")
        @btnRetour.signal_connect('clicked'){
            @grille.sauvegarder(@compte)
            Thread.kill(@threadChrono)
            @window.destroy()
            Menu.new()
        }

        @btnValid1 = @builderJeu.get_object("btnvalid1")
        @btnValid1.signal_connect('clicked'){@grille.creerHypothese()}

        @btnSuppr1 = @builderJeu.get_object("btnsup1")
        @btnSuppr1.signal_connect('clicked'){@grille.supprimeHypothese()}

        @btnValCP = @builderJeu.get_object("btnVerifCP")
        @btnValCP.signal_connect('clicked'){@grille.valideHypothese()}

        @btnSauvegarder = @builderJeu.get_object("btnsave")
        @btnSauvegarder.signal_connect('clicked'){@grille.sauvegarder(@compte)}

        @labelIndice = @builderJeu.get_object("labelIndice")

        @btnDonnerTech = @builderJeu.get_object("btnIndice")
        @btnDonnerTech.signal_connect('clicked'){@labelIndice.set_label(@donnerTech.aider())}

        @btnVerif = @builderJeu.get_object("btnVerifGrille")
        @btnVerif.signal_connect('clicked'){@verifGrille.aider()}

        @btnValidGrille = @builderJeu.get_object("btnValidGrille")
        @btnValidGrille.signal_connect('clicked'){
            @grille.sauvegarder(@compte)
            if(@grille.fini?() == true)
                Thread.kill(@threadChrono)
                fenetre_fin = FenetreFinUI.new(@grille,@compte,@window)
            else
                @labelIndice.set_label("Vous n'avez pas trouvé la solution ! \n Continuez ...")
            end
        }

        @chronoGrille = Chrono.new(self,  @labelChrono)
        @threadChrono = Thread.new{@chronoGrille.lancerChrono()}

        @btnAide = @builderJeu.get_object("btnAide")
        @btnRegles = @builderJeu.get_object("btnRegles")
        @btnAstuces = @builderJeu.get_object("btnAstuces")

        @grille111 = @builderJeu.get_object("grid1")
        @grille111.style_context.add_provider(@@CSS_BOX_STAT, Gtk::StyleProvider::PRIORITY_USER)



        @btnAide.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnRegles.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnAstuces.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)

        @btnValid1.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnSuppr1.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnValCP.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnSauvegarder.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)

        @btnRetour.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnDonnerTech.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @clickRedo.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @clickUndo.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnReinit.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnVerif.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)
        @btnValidGrille.style_context.add_provider(@@CSS_BTN_JEU, Gtk::StyleProvider::PRIORITY_USER)

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

    def actualiseScore()
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
