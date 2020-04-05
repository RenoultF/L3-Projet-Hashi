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
        @window.show()

        #autre
        @labelPseudo = @builderJeu.get_object("lbPseudo")
        @labelPseudo.set_label("Joueur : "+ @pseudo)
        @labelChrono = @builderJeu.get_object("chrono")
        @labelScore = @builderJeu.get_object("lbVarScore")
        
        
        @jeu = Jeu.creer(@difficulte,@taille,@compte,self,@labelChrono, @labelScore)
        @checkpoints = Pile.creer()
        @verifGrille = VerifierGrille.creer(@grille)
        @donnerTech = DonnerTechnique.creer(@grille)
        #@chronoGrille = Chrono.new(@jeu)
        #@threadChrono = Thread.new{@chronoGrille.lancerChrono()}
        @threadJeu = Thread.new{@jeu.lanceToi()}
        
        Gtk.main() 
    end

    def AfficherGrille()

        grilleJeux = @builderJeu.get_object("grilleJeux")
        (0..@jeu.grille.tailleX-1).each do |i|
            (0..@jeu.grille.tailleY-1).each do |j|
                # puts "taille X #{@jeu.grille.tailleX}"
                # puts "taille Y #{@jeu.grille.tailleY}"
                temp = @jeu.grille.getCase(i,j)
                boutton = Gtk::Button.new(:label => "1", :use_underline => nil, :stock_id => nil)

                grilleJeux.attach boutton, i, j, 1, 1
            end
        end
        
    end
end