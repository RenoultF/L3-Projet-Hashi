require 'gtk3'

require './ConnectSqlite3.rb'

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

class JeuUI


    def initialize(mode, taille, difficulte,pseudo)
        @mode = mode
        @taille = taille #1 = 7*7 /// 2 = 10*10 /// 3 = 15*15
        @difficulte = difficulte
        @pseudo = pseudo.text()
        puts "Pseudo : #{@pseudo}";
        @compte = Compte.recuperer(@pseudo)

        # puts "Mode : #{@mode}";
        # puts "Taille : #{@taille}";
        # puts "Difficulté : #{@difficulte}";
         

        # CREATION FENETRE 
        @builderJeu = Gtk::Builder.new
        @builderJeu.add_from_file("../glade/jeu.glade")
        @window = @builderJeu.get_object("windowJeu")
        @window.show()

        @grille = chargerGrille(difficulte, tailleGrille, compte)
        @checkpoints = Pile.creer()
        @verifGrille = VerifierGrille.creer(@grille)
        @donnerTech = DonnerTechnique.creer(@grille)
        @chronoGrille = Chrono.new(@grille)
        @threadChrono = Thread.new{@chronoGrille.lancerChrono()}
        
        self.AfficherGrille(@taille)
        Gtk.main() 
    end

    def AfficherGrille(taille)
        grilleJeux = builder.get_object("grilleJeux")

        (0..@grille.tailleX-1).each do |i|
            (0..@pgrille.tailleY-1).each do |j|
                temp = @grille.getCase(i,j).Gtk::Button.new("1")
                grilleJeux.attach temp, j, i, 1, 1
            end
        end
    end
end