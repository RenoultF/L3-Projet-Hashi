class Highscore
    #@liste Liste de tout les highscores de la carte / Besoin de stocker le score avec le pseudo ou reference au pseudo
    #@max Maximum de la liste afin de pouvoir placer de nouvelles valeurs
    #@grille La grille sur laquelle le joueur joue
    #@compte Reference au compte du joueur
    private_class_method :new

    def Highscore.creation(grille)
        new(grille)
    end

    def initialize(grille)
        @grille = grille
        @liste = Hash.new()
        @contenu = 0
        @max = 0
        @min = 0
    end

    def ajouter(cle,valeur)
        if @contenu < 3
            @liste[cle] = valeur
            @contenu += 1
        elsif @contenu >= 3
            min = self.minimum()
            @liste.delete(min)
            @liste[cle] = valeur
        else
            puts "Impossible d'ajouter, nombre d'élements max atteint !\n\n"
        end
    end
    #Marche pas
    def trie()
        @liste.sort_by {|score, pseudo| score}
        self.afficher
    end

    def maximum()
        @liste.each_key do |key|
            if(key>@max)
                @max = key
            end
        end

        return @max
    end

    def minimum()
        @min = @liste.keys[0]
        @liste.each_key do |key|
            if(key<@min)
                @min = key
            end
        end

        return @min
    end

    def afficher()
        puts "      Highscore       \n\n"
        i = 0
        taille = 1
        @liste.each_pair do |key, value|
            print key 
            puts "=>" + value
        end
    end

end


tab = Highscore.creation
=begin
#Test ajout
tab.ajouter(3500,"Soares")
tab.ajouter(5000,"Soares")
tab.ajouter(350,"Ordinateur")
tab.afficher
tab.ajouter(1550,"Ordi")
#Test du max
max = tab.maximum()
puts max
#Test du min
min = tab.minimum()
puts min
#Test affichage
tab.afficher
=end

tab.ajouter(1000, "Player 1")
tab.ajouter(900, "Player 2")
tab.ajouter(1100, "Player Test")
tab.trie()
tab.afficher

