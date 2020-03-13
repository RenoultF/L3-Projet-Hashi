require 'scanf'
require "./Grille2Essai.rb"
require "./Aide.rb"
require "./Sauvegarde.rb"
require "./Compte.rb"
require "./Checkpoint.rb"
require "./DonnerTechnique.rb"
require "./VerifierGrille.rb"
require "./Action.rb"
##
#classe qui s'occupe du déroulement d'une partie
class Jeu

    private_class_method :new

    @compte #le compte Darcula
    @grille #la grille ou se deroule la partie
    @grilleSolution #la grille complétée
    @tech #objet qui fournit des aides techniques
    @verif # objet qui vérifie la grille
    @checkPoint #objet qui gere les hypotheses

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
        @tech = DonnerTechnique.new()
        @verif = VerifierGrille.new()
        @checkPoint = Checkpoint.creer(@grille)
        @compte = compte
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
        i = Random.new
        return lst[i.rand(lst.count())].getGrille()
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
            case action
            when 1
                ile1 = demandeCoord
                @grille.setDernierIle(ile1)
                ile2 = demandeCoord
                @grille.createPont(ile2)
                valeurPont = @grille.valeurPont(ile1, ile2)
                if(ile1.posX == ile2.posX)
                  x = ile1.posX
                  y = ile1.posY + 1
                elsif(ile1.posY == ile2.posY)
                  x = ile1.posX + 1
                  y = ile1.posY
                else
                  puts "Vous etes teubé"
                end
                if(valeurPont == 0)
               #   Action.new(@grille.getCase(x, y), @grille, 0).empiler
                elsif(valeurPont != 0)
               #   Action.new(@grille.getCase(x, y), @grille, 1).empiler
                end
            when 2
                afficherAide(@tech.demandeAide(@grille, @grilleSolution))
            when 3
                @checkPoint.emettre
            when 4
                @checkPoint.valider
            when 5
                @checkPoint.supprimer_derniere_action
            when 6
                @checkPoint.supprimer_checkpoint
            when 7
                win = verif.demandeAide(@grille, @grilleSolution)
            when 8
                puts Sauvegarde.creer(@compte, @grille).inspect()
                Sauvegarde.creer(@compte, @grille).remplace()
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
        puts "2 : demander une aide\n"
        puts "3 : emetre hypothese\n"
        puts "4 : valider hypothese\n"
        puts "5 : retour arriere\n"
        puts "6 : supprimer hypothese\n"
        puts "7 : valider grille\n"
        puts "8 : Sauvegarder la grille\n"

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
        return @grille.getCase(x, y)
    end
end
