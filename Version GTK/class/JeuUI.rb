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

load '../CSS/Style.rb'

class JeuUI


    def initialize(mode, taille, difficulte,pseudo,window)
        @mode = mode
        case taille
            when 1
                @taille = 7
            when 2
                @taille = 10
            when 3
                @taille = 15        
            else
                puts "PROBLEME TAILLE"            
        end

        @difficulte = difficulte
        @pseudo = pseudo.text()
        if (@pseudo == nil)
            @pseudo.placeholder_text('RENTRE UN PSEUDO')
            # @pseudo.style_context.add_provider(@@CSS_ENTRY_MENU, Gtk::StyleProvider::PRIORITY_USER)
            #colorer bord de l'entry en rouge et rajouter text holder entry
        else            
            puts "Pseudo : #{@pseudo}";
            @compte = Compte.recuperer(@pseudo)
            window.destroy() 
        end
        
        

        # puts "Mode : #{@mode}";
        # puts "Taille : #{@taille}";
        # puts "Difficulté : #{@difficulte}";
         
         
        # CREATION FENETRE 
        puts "creation"
        @builderJeu = Gtk::Builder.new
        @builderJeu.add_from_file("../glade/jeu.glade")

        # -- GET_OBJECT
            @window = @builderJeu.get_object("windowJeu")

            @btnAide = @builderJeu.get_object("btnAide")
            @btnRegles = @builderJeu.get_object("btnRegles")
            @btnAstuces = @builderJeu.get_object("btnAstuces")

            @labelPseudo = @builderJeu.get_object("lbPseudo")
            
            @labelChrono = @builderJeu.get_object("chrono")
            @labelScore = @builderJeu.get_object("lbVarScore")

            @clickUndo = @builderJeu.get_object("btnRetourarr")
            @btnValid1 = @builderJeu.get_object("btnvalid1")
            @btnSuppr1 = @builderJeu.get_object("btnsup1")
            @btnValid2 = @builderJeu.get_object("btnvalid2")
            @btnSuppr2 = @builderJeu.get_object("btnsup2")
            @btnValid3 = @builderJeu.get_object("btnvalid3")
            @btnSuppr3 = @builderJeu.get_object("btnsup3")
            @btnSauvegarder = @builderJeu.get_object("btnsave")

            @btnRetour = @builderJeu.get_object("btnRetour")
            @btnDonnerTech = @builderJeu.get_object("btnIndice")
            @btnVerif = @builderJeu.get_object("btnVerif")

        # SIGNAL_CONNECT
            @clickUndo.signal_connect('clicked'){@grille.undo()}
            @btnValid1.signal_connect('clicked'){@grille.creerHypothese()}
            @btnSuppr1.signal_connect('clicked'){@grille.supprimeHypothese(@jeu)}
            @btnValid2.signal_connect('clicked'){@grille.creerHypothese()}
            @btnSuppr2.signal_connect('clicked'){@grille.supprimeHypothese(@jeu)}
            @btnValid3.signal_connect('clicked'){@grille.creerHypothese()}            
            @btnSuppr3.signal_connect('clicked'){@grille.supprimeHypothese(@jeu)}
            @btnSauvegarder.signal_connect('clicked'){Sauvegarde.recuperer(@compte, @grille).setGrille(@grille).sauvegarder()}
            @btnDonnerTech.signal_connect('clicked'){@donnerTech.aider()}
            @btnVerif.signal_connect('clicked'){@donnerTech.aider()}

        # --- BTN ---
            @btnRetour.signal_connect('clicked') { |_widget| puts"Chenger fenetre" }
            @btnAide.signal_connect('clicked') { puts "--- Affichage des aides";  }
            @btnRegles.signal_connect('clicked') { puts "--- Affichage des règles";  }
            @btnAstuces.signal_connect('clicked') { puts "--- Affichage des astuces"; }

        #autre
        @labelPseudo.set_label("Joueur : "+ @pseudo)
        #Creation du jeu
        @jeu = Jeu.creer(@difficulte,@taille,@compte,self,@labelChrono, @labelScore)
        
        @grille = @jeu.grille
        p ("grille = #{@grille}")
        @checkpoints = Pile.creer()
        @verifGrille = VerifierGrille.creer(@grille)
        @donnerTech = DonnerTechnique.creer(@grille)

        #fonctions
        

        #@chronoGrille = Chrono.new(@jeu)
        #@threadChrono = Thread.new{@chronoGrille.lancerChrono()}
        @threadJeu = Thread.new{@jeu.lanceToi()}
        @window.show_all()
        Gtk.main() 
    end

    def AfficherGrille()
        grilleJeux = @builderJeu.get_object("grilleJeux")
        bouton = Gtk::Button.new(:label => " ")
        (0..@grille.tailleX-1).each do |i|
          (0..@grille.tailleY-1).each do |j|
                bouton = Gtk::Button.new(:label => " ")
                #puts "taille X #{@grille.tailleX}"
                #puts "taille Y #{@grille.tailleY}"
                temp = @grille.getCase(i,j)
                #boutton = Gtk::Button.new(:label => "COUCOU")
                if(temp.instance_of? Pont)
    
                    bouton.set_label("#{temp.valeur.to_s}")
                    #puts "C EST UN PONT"
                    #creation du bouton pont
                elsif(temp.instance_of? Ile)
                    bouton.set_label("#{temp.valeur.to_s}")
                    #puts "C EST UNE ILE"
                elsif(temp.instance_of? Case)
                    bouton.set_label("case")
                    #puts "C EST UNE CASE"
                else
                    puts "PROBLEME INSTANCE"
                end

            grilleJeux.attach bouton, i, j, 1, 1
            end
        end
        @window.show_all()
    end

    # def AffFenetrePrec()
    #     @window.destroy()
	# 	@menu = Menu.new()       
    # end
end