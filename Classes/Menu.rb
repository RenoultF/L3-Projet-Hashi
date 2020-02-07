class Menu

    private_class_method :new

    def Menu.Creer()
        new()
    end

    def initialize()

        @mode = Hash.new()
        @mode["Normal"] = 1
        @mode["Aventure"] = 2

        @difficulte = Hash.new()
        @difficulte["Facile"] = 1
        @difficulte["Normal"] = 2
        @difficulte["Difficile"] = 3

        @tailleGrille = Hash.new()
        @tailleGrille["7x7"] = 1
        @tailleGrille["10x10"] = 2
        @tailleGrille["15x15"] = 3

        @pseudo = ""
    end

    def setTailleGrille(choixTaille)
        dimension = Hash.new()
        case choixTaille
        when 1
            dimension["x"]=7
            dimension["y"]=7
        when 2
            dimension["x"]=10
            dimension["y"]=10
        when 3
            dimension["x"]=15
            dimension["y"]=15
        else
            print("Probleme avec le choix num = " + choixTaille + "\n")
        end

        return dimension
    end

    def setMode(choixMode)
       return choixMode
    end

    def setDifficulte(choixDifficulte)
        return choixDifficulte
    end

    #Cette méthode permet de connaitre le compte associé à un unPseudo
    #
    #@param unPseudo Le pseudo du comptes
    #
    #@return Le compte qui correspond au unPseudo
    #
    #Si le compte n'existait pas alors un nouveau est crée et enregistré
    def seConnecter(unPseudo)
        @pseudo = unPseudo

        recupCompte = Compte.find_or_create_by pseudo: @pseudo

        if(recupCompte == nil)

          print "Le compte n'existait pas, il a été crée"

        end

        return recupCompte

    end

    def afficheRegle()
        return "Le principe est de relier tous les points afin de ne former qu'un seul ensemble. Chaque point indique le nombre de lignes qui lui sont reliées. Un point peut être relié par le haut, le bas à gauche ou à droite. Dans chaque direction il peut y avoir zéro, une ou deux lignes. De plus, deux ponts ne peuvent se croiser !"
    end

end

men = Menu.Creer()
tabDim = Hash.new()
tabDim=men.setTailleGrille(2)
print(tabDim)
