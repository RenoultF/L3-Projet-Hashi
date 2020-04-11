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
        

        #autre
        @labelPseudo = @builderJeu.get_object("lbPseudo")
        @labelPseudo.set_label("Joueur : "+ @pseudo)
        @labelChrono = @builderJeu.get_object("chrono")
        @labelScore = @builderJeu.get_object("lbVarScore")
        #Creation du jeu
        @jeu = Jeu.creer(@difficulte,@taille,@compte,self,@labelChrono, @labelScore)
        
        @grille = @jeu.grille
        p ("grille = #{@grille}")
        @checkpoints = Pile.creer()
        @verifGrille = VerifierGrille.creer(@grille)
        @donnerTech = DonnerTechnique.creer(@grille)

        #fonctions
        @clickUndo = @builderJeu.get_object("btnRetourarr")
        @clickUndo.signal_connect('clicked'){@grille.undo()}

        @btnValid1 = @builderJeu.get_object("btnvalid1")
        @btnValid1.signal_connect('clicked'){@grille.creerHypothese()}

        @btnSuppr1 = @builderJeu.get_object("btnsup1")
        @btnSuppr1.signal_connect('clicked'){@grille.supprimeHypothese(@jeu)}

        @btnValid2 = @builderJeu.get_object("btnvalid2")
        @btnValid2.signal_connect('clicked'){@grille.creerHypothese()}

        @btnSuppr2 = @builderJeu.get_object("btnsup2")
        @btnSuppr2.signal_connect('clicked'){@grille.supprimeHypothese(@jeu)}

        @btnValid3 = @builderJeu.get_object("btnvalid3")
        @btnValid3.signal_connect('clicked'){@grille.creerHypothese()}
        
        @btnSuppr3 = @builderJeu.get_object("btnsup3")
        @btnSuppr3.signal_connect('clicked'){@grille.supprimeHypothese(@jeu)}

        @btnSauvegarder = @builderJeu.get_object("btnsave")
        @btnSauvegarder.signal_connect('clicked'){Sauvegarde.recuperer(@compte, @grille).setGrille(@grille).sauvegarder()}

        @btnDonnerTech = @builderJeu.get_object("btnIndice")
        @btnDonnerTech.signal_connect('clicked'){@donnerTech.aider()}

        @btnVerif = @builderJeu.get_object("btnVerif")
        @btnVerif.signal_connect('clicked'){@donnerTech.aider()}

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
end