

##
# Auteur Brabant Mano, Serelle Erwan
# Version 0.1 : Date : 07/02/2020


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
##
#Cette classe permet de s'occuper du déroulement d'une partie
class Jeu

    private_class_method :new

    @compte #le compte Darcula
    @grille #la grille ou se deroule la partie
    @grilleSolution #la grille complétée
    @tech #objet qui fournit des aides techniques
    @verif # objet qui vérifie la grille
    @checkpoints #objet qui gere les hypotheses

    attr_accessor :grille

    #Ce constructeur permet de creer un nouveau Jeu
    #
    #:arg: difficulte
    #:arg: tailleGrille : Entier
    #:arg: compte : Compte
    def Jeu.creer(difficulte, tailleGrille, compte)
        new(difficulte, tailleGrille, compte)
    end

    #:nodoc:
    def initialize(difficulte, tailleGrille, compte)
        @grille = chargerGrille(difficulte, tailleGrille, compte)
        @compte = compte
        @checkpoints = Pile.creer()
        @verifGrille = VerifierGrille.creer(@grille)
        @donnerTech = DonnerTechnique.creer(@grille)
        @chronoGrille = Chrono.new(@grille)
    #    @threadChrono = Thread.new{@chronoGrille.lancerChrono()}
    end
    #:doc

    ##
    #charge une grille pour une partie
    #:arg: difficulte
    #:arg: tailleGrille : Entier
    #:arg: compte : Compte
    #@return Grille
    def chargerGrille(difficulte, tailleGrille, compte)
        lst = Sauvegarde.liste(compte, tailleGrille, difficulte)
        if(lst.count() == 0)
            raise("Y a pas de sauvegarde")
        end
        lst.each_with_index do |s, index|
          print "\n", index, ":", "\n"
          s.getGrille().afficheToi()
        end
        res = -1
        while(res < 0 || res >= lst.length)
          res = gets.chomp().to_i()
        end
        return lst[res].getGrille()
    end

    ##
    #algorithme du jeu
    #:arg: grille : Grille
    #:arg: compte : Compte
    #@return win : Boolean
    def lanceToi()
        win = false #T'es mauvais Jack
        while(!win)
            @grille.afficheToi
            case action()
            when 1
              begin
                ile2 = demandeCoord()
                @grille.clickOnIle(ile2)
              rescue => e
                puts "Erreur : " +  e.message()
              end
            when 2
                @grille.undo()
            when 3
                @grille.redo()
            when 4
              puts "_______________________"
                Sauvegarde.recuperer(@compte, @grille).getGrille().afficheSolution()
                puts @grille
                puts Sauvegarde.recuperer(@compte, @grille).setGrille(@grille).sauvegarder()
                puts "_______________________"
            when 5
                @grille.creerHypothese()
            when 6
                @grille.valideHypothese()
            when 7
                @grille.supprimeHypothese(self)
            when 8
                @verifGrille.aider()
            when 9
                @donnerTech.aider()
            else
                puts "puts"
            end
        end
    end



    ##
    #affichage de l'aide
    #:arg: aide : String
    def afficherAide(aide)
      puts aide
    end

    ##
    #decide de l'action du joueur
    #@return Entier
    def action
        puts "1 : pose/supprime un pont\n"
        puts "2 : undo\n"
        puts "3 : redo\n"
        puts "4 : Sauvegarder la grille\n"
        puts "5 : Creer hypothese\n"
        puts "6 : Valider hypothese\n"
        puts "7 : Supprimer hypothese\n"
        puts "8 : Verifier grille\n"
        puts "9 : Donner technique\n"
        return gets.chomp.to_i
    end

    ##
    #demande des coordonnées à l'utilisateur pour la sélection d'une case dans la grille
    #@return Case
    def demandeCoord
        puts "Saisir coordonnées d'une ile :"
        puts "coordonnée en x : "
        x = gets.chomp.to_i
        puts "coordonnée en y : "
        y = gets.chomp.to_i
        if(@grille.sortLimite?(x, y))
          raise("Les coordonnée ne sont pas correctes")
        end
        if(!@grille.getCase(x, y).estIle?())
          raise("La case n'est pas une ile")
        end
        return @grille.getCase(x, y)
    end
end
