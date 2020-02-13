class Jeu

    private_class_method :new

    @grille #la grille ou se deroule la partie

    def Jeu.creer()
        new()
    end

    def initialize()
        @grille = nil
    end

    def chargerGrille(mode, difficulte, tailleGrille,compte)

    end

    def lanceToi(grille, compte)

    end
end