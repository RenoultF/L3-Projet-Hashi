require 'scanf'
class Jeu

    private_class_method :new

    @grille #la grille ou se deroule la partie
    @grilleSolution
    @tech
    @verif
    @checkPoint

    def Jeu.creer()
        new()
    end

    def initialize(difficulte, tailleGrille,compte)
        @grille = chargerGrille(mode, difficulte, tailleGrille,compte)
        @tech = new DonnerTechnique
        @verif = new VerifierGrille
        @checkPoint = new CheckPoint(grille)
    end

    def chargerGrille(difficulte, tailleGrille, compte)
        lst = Sauvegarde.liste(difficulte, tailleGrille, compte)
        i = Random.new
        Sauvegarde.getGrille(lst[i.random(lst.lenght)])
    end

    def lanceToi(grille, compte)
        win = false
        while(!win)
            grille.afficheToi
            case action
            when 1
                grille.setDernierIle(demandeCoord)
                grille.createPont(demandeCoord)
            when 2
                puts tech.demandeAide(@grille, @grilleSolution)
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
            end
        end
    end

    def action
        puts "1 : pose/supprime un pont"
        puts "2 : demander une aide"
        puts "3 : emetre hypothese"
        puts "4 : valider hypothese"
        puts "5 : retour arriere"
        puts "6 : supprimer hypothese"
        puts "7 : valider grille"

        str.scanf("%d")
    end

    def demandeCoord
        puts "Saisir coordonnées d'une ile :"
        puts "coordonnée en x : "
        x.scanf("%d")
        puts "coordonnée en y : "
        y.scanf("%d")
        return grille.mat[x][y]
    end
end