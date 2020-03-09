require 'scanf'
require "./Grille2Essai.rb"
require "./Aide.rb"
require "./Sauvegarde.rb"
require "./Compte.rb"
require "./Checkpoint.rb"
##
#classe qui s'occupe du déroulement d'une partie
class Jeu

    private_class_method :new

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
        @grille = chargerGrille(mode, difficulte, tailleGrille,compte)
        @tech = DonnerTechnique.new()
        @verif = VerifierGrille.new()
        @checkPoint = CheckPoint.creer(grille)
    end
    #:doc

    ##
    #charge une grille pour une partie
    #:arg: difficulte
    #:arg: tailleGrille : Entier
    #:arg: compte : Compte
    #@return Grille
    def chargerGrille(difficulte, tailleGrille, compte)
        lst = Sauvegarde.liste(difficulte, tailleGrille, compte)
        i = Random.new
        return lst[i.random(lst.lenght)].getGrille()
    end

    ##
    #algorithme du jeu
    #:arg: grille : Grille
    #:arg: compte : Compte
    #@return win : Boolean
    def lanceToi(grille, compte)
        win = false
        while(!win)
            grille.afficheToi
            case action
            when 1
                tab1 = demandeCoord
                grille.setDernierIle(tab1)
                tab2 = demandeCoord
                grille.createPont(tab2)
                valeurPont = valeurPont(grille.mat[tab1[0], tab1[1]], grille.mat[tab2[0], tab2[1]])
                if(tab1[0] == tab2[0])
                  x = tab1[0]
                  y = tab1[1]+1
                elsif
                  x = tab1[0]+1
                  y = tab1[1]
                end
                if(valeurPont == 0)
                  Action.new(grille.mat[x, y], grille, 0).empiler
                elsif
                  Action.new(grille.mat[x, y], grille, 1).empiler
                end
            when 2
                afficherAide(tech.demandeAide(@grille, @grilleSolution))
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
                Sauvegarde.creer(compte, grille).sauvegarder()
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

        str.scanf("%d")
    end

    ##
    #demande des coordonnées à l'utilisateur pour la sélection d'une case dans la grille
    #@return Case
    def demandeCoord
        puts "Saisir coordonnées d'une ile :"
        puts "coordonnée en x : "
        x.scanf("%d")
        puts "coordonnée en y : "
        y.scanf("%d")
        return grille.mat[x][y]
    end
end
